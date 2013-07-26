function! android#build#debug()
  make "debug"
endfunction

function! android#build#clean()
  make "clean"
endfunction

function! android#build#release()
  make "release"
endfunction
