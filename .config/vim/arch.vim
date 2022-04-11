autocmd BufWritePost ~/forge/dwmblocks/config.h !cd ~/forge/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
