autocmd BufWritePost ~/forge/dwmblocks/config.h !cd ~/forge/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
