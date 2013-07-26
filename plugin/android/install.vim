function! android#install#debug()
  call android#build#debug()
  make "installd"
endfunction

function! android#install#release()
  call android#build#release()
  make "installr"
endfunction
