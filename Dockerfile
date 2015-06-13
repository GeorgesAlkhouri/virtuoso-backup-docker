FROM ubuntu:latest
MAINTAINER Georges Alkhouri <georges.alkhouri@stud.htwk-leipzig.de>

ENV DEBIAN_FRONTEND noninteractive

ENV GIT_REPO ""
ENV GIT_EMAIL ""
ENV GIT_NAME ""
ENV CRONTAB "0 0 * * *"
ENV GIT_REPO_PATH "/backup-repository"
ENV BACKUP_PATH "/backup_store"

RUN apt-get update
RUN apt-get install -y git virtuoso-opensource rapper

# Add backup script which the cron job is going to run
ADD backup.sh /usr/bin/
ADD run.sh /usr/bin/
ADD normalize.sh /usr/bin/

RUN chmod +x /usr/bin/backup.sh
RUN chmod +x /usr/bin/run.sh
RUN chmod +x /usr/bin/normalize.sh

# Needed to push to git through ssh
VOLUME "/root/.ssh"
 
# Run the command on container startup
CMD /usr/bin/run.sh
