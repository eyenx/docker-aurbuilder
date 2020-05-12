FROM archlinux:latest

LABEL maintainer="Toni Tauro <eye@eyenx.ch>"


ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN pacman -Syy && pacman -S base-devel --noconfirm && pacman -Su --noconfirm && \
    useradd -m aur && echo "aur ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    pacman-key --init && pacman-key --populate archlinux && chmod +x /docker-entrypoint.sh

USER aur

RUN cd /home/aur && curl https://aur.archlinux.org/cgit/aur.git/snapshot/auracle-git.tar.gz | tar xvzf - && \
    cd auracle-git && makepkg -si --noconfirm && cd ../ && rm -rf /home/aur/auracle-git && 
    gpg --recv-keys 1D1F0DC78F173680 && \
    gpg --recv-keys 4773BD5E130D1D45 && \
    gpg --recv-keys EB774491D9FF06E2 && \
    sudo rm -rf /var/lib/pacman/sync/* && sudo rm -rf /var/cache/pacman

VOLUME /export

WORKDIR /home/aur

ENTRYPOINT ["/docker-entrypoint.sh"]
