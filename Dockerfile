	
FROM	archlinux:latest
LABEL	org.opencontainers.image.authors="Toni Tauro <eye@eyenx.ch>"
ADD	docker-entrypoint.sh	/docker-entrypoint.sh
RUN	pacman -Syy \
	&& pacman -S base-devel perl libffi icu --noconfirm \
	&& pacman -Su --noconfirm \
	&& useradd -m aur \
	&& echo "aur ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
	&& pacman-key --init \
	&& pacman-key --populate archlinux \
	&& chmod +x /docker-entrypoint.sh
USER	aur
RUN	cd /home/aur \
        && mkdir .gnupg \
        && echo keyserver keyserver.ubuntu.com >> .gnupg/gpg.conf \
	&& curl https://aur.archlinux.org/cgit/aur.git/snapshot/auracle-git.tar.gz | tar xvzf - \
	&& cd auracle-git \
	&& makepkg -si --noconfirm \
	&& cd ../ \
	&& rm -rf /home/aur/auracle-git \
	&& sudo rm -rf /var/lib/pacman/sync/* \
	&& sudo rm -rf /var/cache/pacman \
	&& cat /etc/profile.d/perlbin.sh >> .bashrc
ENV	PATH	/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
VOLUME	/export
WORKDIR	/home/aur
ENTRYPOINT	["/docker-entrypoint.sh"]
