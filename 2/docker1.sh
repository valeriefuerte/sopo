sudo docker run 
--volume /home/user/.ssh:/root/.ssh 
--volume /home/user/Sopo_main:/Sopo_main 
--volume /root/.ansible/roles:/root/.ansible/roles/ ansible ansible-playbook -i  /sopo/environments/dev/inventory 
/sopo/playbooks/docker.yml -D 
