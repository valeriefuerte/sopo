docker run 
--volume /home/user/.ssh/:/root/.ssh/ 
--volume /home/user/valeria_sopo/sopo/2/:/2/ 
--volume /root/.ansible/tmp/:/root/.ansible/tmp/ 
ansible ansible-playbook -i 2/environments/dev/inventory 2/playbooks/docker.yml -D
