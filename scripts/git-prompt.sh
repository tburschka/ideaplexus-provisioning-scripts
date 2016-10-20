#!/usr/bin/env bash

if ! grep -q "vcs" "/tmp/provisioning"; then
  sh /provisioning/scripts/vcs.sh
fi

echo "git-prompt" >> /tmp/provisioning

cd /tmp
git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1

cp -R /tmp/.bash-git-prompt /home/vagrant
echo "source ~/.bash-git-prompt/gitprompt.sh" >> /home/vagrant/.bashrc
echo "GIT_PROMPT_ONLY_IN_REPO=1" >> /home/vagrant/.bashrc
chown -R vagrant:vagrant /home/vagrant/.bashrc /home/vagrant/.bash-git-prompt

cp -R /tmp/.bash-git-prompt /root
echo "source ~/.bash-git-prompt/gitprompt.sh" >> /root/.bashrc
echo "GIT_PROMPT_ONLY_IN_REPO=1" >> /root/.bashrc

rm -rf cp /tmp/.bash-git-prompt