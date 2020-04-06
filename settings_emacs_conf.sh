#!/bin/bash

emacs=`ls -a /home/\`whoami\`/.emacs.d/init.el`

if [ ! $emacs ]; then
    emacs="/home/`whoami`/.emacs.d/init.el"
fi

echo "(add-to-list 'load-path \"`pwd`\")" >> $emacs
echo "(load \"shigi-init\")" >> $emacs
