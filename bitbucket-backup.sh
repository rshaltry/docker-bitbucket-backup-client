#!/bin/bash

BACKUP_PATH=/backup/bitbucket    # Path to BitBucket backups
DAYS_TO_KEEP=3                   # Days to keep old backups
AWS_PROFILE=default              # AWS CLI profile name
AWS_S3_BUCKET=mybucket-backups   # AWS S3 bucket name
AWS_S3_DESTINATION=bitbucket     # Directory name for backup sync

# Determine paths for script and executables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DOCKER_COMPOSE=$(which docker-compose)
FIND=$(which find)
GZIP=$(which gzip)
AWS=$(which aws)

$DOCKER_COMPOSE -f $DIR/docker-compose.yml run --rm bitbucket-backup \
  && $FIND $BACKUP_PATH -mtime +$DAYS_TO_KEEP -exec rm -f "{}" \; \
  && $GZIP $BACKUP_PATH/*.tar \
  && $AWS s3 sync $BACKUP_PATH s3://$AWS_S3_BUCKET/$AWS_S3_DESTINATION --profile $AWS_PROFILE --delete
