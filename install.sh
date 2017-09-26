#!/bin/bash
####################################################
#                                                    
#  Author: lzgabel                                   
#  Mail: lz19960321lz@163.com                        
#  Remark:                                           
#  Created Time: 2017年09月21日 星期四 17时36分31秒
#                                                    
####################################################
PATH=/bin:/sbin:/usr/bin:/usr/sbin:~/bin
export PATH

echo "安装将花费一定时间，请耐心等待^_^"
if which apt-get >/dev/null; then
	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev git tmux zsh 
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel git tmux zsh	
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null; then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle zsh tmux 
fi

#get Oh-My-zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" 
if [ ! -f "/usr/bin/ctags" ]; then
	sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
fi

echo "安装完毕将自动退出"
echo "请耐心等待..."

#backup vim to vim_old
if [  -d ".vim" ]; then
	mv  -f .vim .vim_old
elif [  -f ".vimrc" ]; then
	mv -f .vimrc .vimrc_old
fi 

mkdir ~/.vim  && tar -zxf vim.tar.gz -C ~/.vim
cd ~/.vim/bundle/ && git clone git@github.com:Valloric/YouCompleteMe.git && cd YouCompleteMe && git submodule update --init --recursive
cd ~/.vim/bundle/YouCompleteMe/ && ./install.py --clang-completer
cp ~/.vim/vimrc ~/.vimrc
cp ~/.vim/ycm_extra_conf.py ~/.ycm_extra_conf.py
cp ~/.vim/tmux.conf ~/.tmux.conf
cp ~/.vim/tmux.conf.local ~/.tmux.conf.local
echo "安装完成"
