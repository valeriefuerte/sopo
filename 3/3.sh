sudo docker run --detach \
--hostname 192.168.56.102 \ #(1st VM address)
--publish 443:443 --publish 80:80 \
--name gitlab102 \
--restart always \
--volume $GITLAB_HOME/config:/etc/gitlab \
--volume $GITLAB_HOME/logs:/var/log/gitlab \
--volume $GITLAB_HOME/data:/var/opt/gitlab \
gitlab/gitlab-ee:latest

git clone http://localhost/root/ansible-ci.git

# create .gitlab-ci.yml
# Gitlab: go to menu "Administrator, ansible-CI, Details"
# Add SSH key from 1st VM


# install gitlab-runner on 2nd VM


sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 

sudo chmod +x /usr/local/bin/gitlab-runner 

sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash 

sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner 

sudo gitlab-runner start 

# nano /etc/gitlab-runner/config.toml 

ps aux | grep gitlab


# Register gitlab runner
Gitlab-runner register
url: 192.168.102
Token Kt8GCKRjAGywpsqm4Fdq
Name : ubuntu
Tags … upd1
Shell

# On gitlab on top menu click on settings
# On left menu "Runners"
# To unlock click Edit, unclick "Lock to current projects: When a runner is locked, it cannot be assigned to other projects"

# For do not use sudo and password:
# on 2nd VM add string in dir /etc/sudoers
# gitlab-runner ALL=(ALL) NOPASSWD: ALL

# Check logs on gitlab, menu 'CI/CD, pipelines, jobs'
