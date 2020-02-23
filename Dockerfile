from alpine:edge

# add repositories
run echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
run echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# update packages
run apk update

# update and install packages
run apk update
run apk upgrade
run apk add openconnect@testing freerdp@community bash bash-completion zsh tmux nano sudo openssh iputils wget git

# load tun
run echo "tun" >> /etc/modules-load.d/tun.conf

# create our developer user
run addgroup developer
run adduser --disabled-password developer -G developer --shell /bin/zsh

# allow root
run echo "%developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# switch users
user developer
workdir /home/developer

# custom scripts
run mkdir ./bin
copy /custom-bin ./bin
run chmod +x ./bin/*

#oh my zsh 
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# start a terminal
entrypoint ["tmux"]

