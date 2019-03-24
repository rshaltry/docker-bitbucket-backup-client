FROM java:alpine

ADD https://marketplace.atlassian.com/download/plugins/com.atlassian.stash.backup.client/version/300500000 /root/bitbucket-backup-distribution-3.5.0.zip
RUN cd /root && unzip bitbucket-backup-distribution-3.5.0.zip

WORKDIR /root/bitbucket-backup-client-3.5.0

ENTRYPOINT [ "/bin/sh" ]
