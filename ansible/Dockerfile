FROM ubuntu:18.04
Maintainer "Cyberspace"

RUN apt-get update -y \
    && apt-get install -y openssh-server sudo ansible
RUN echo "ansible-server" > /etc/hostname
 
# Create a ANSIBLE user
RUN echo "Setting user Ansible" \
&& useradd -m ansible -s /bin/bash \
&& chpasswd << 'END' \
ansible:ansible\
END \
&& echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ansible
RUN ssh-keygen -q -t rsa -N '' -f /home/ansible/.ssh/id_rsa
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD bash
