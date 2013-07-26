function! android#util#get_root_directory()
  let current_path = getcwd()
  let items = split(current_path, "/")
  for current_item in items
    if filereadable(current_path . "/AndroidManifest.xml")
      return current_path
    endif

    let current_path = substitute(current_path,"/" .current_item,"","g")
  endwhile
  
  return 0
endfunction

function! android#util#jump_to_root_directory()
  let root_path = androiddev#util#GetRootDirectory()
  if isdirectory(root_path) | cd root_path | endif
endfunction

" NOTE: Not safe.
function! android#util#get_targets()
  return split(system("android list target -c"), "\n")
endfunction
