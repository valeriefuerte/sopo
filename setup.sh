# Open virtual machine in virtual box (Server Ubuntu 18)

# В настройках виртуальной машины выбрать. Сеть. Адаптер 2. Тип подключения: виртуальный адаптер хоста.

ip a
# Смотрим на enp0s8. Если down то:
# sudo nano /etc/network/interfaces

# Пишем в файле: 
# auto enp0s8
# iface enp0s8 inet dhcp

# install gitlab on docker
sudo apt update
sudo apt install python-pip
sudo pip install ansible==2.9.12

# Clone repos
git clone https://github.com/kost2191/docker-role.git
git clone https://github.com/kost2191/sopo.git

# Run playbook
cd sopo
sudo ansible-galaxy install -r roles/requirements.yml --force

# generate ssh
sudo su
ssh-keygen

cd /root/.ssh/
cp id_rsa.pub authorized_keys
sudo cat /root/.ssh/id_rsa.pub
sudo cat /root/.ssh/authorized_keys

# playbook
sudo ansible-playbook -i environments/localhost/inventory playbooks/docker.yml -D

# run docker
sudo docker run --detach \
--hostname localhost \
--publish 443:443 --publish 80:80 \
--name gitlab \
--restart always \
--volume $GITLAB_HOME/config:/etc/gitlab \
--volume $GITLAB_HOME/logs:/var/log/gitlab \
--volume $GITLAB_HOME/data:/var/opt/gitlab \
gitlab/gitlab-ee:latest

sudo docker ps

