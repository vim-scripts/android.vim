function! android#checks#android_home()
  if isdirectory(g:android_sdk_path)
    return 1
  if isdirectory($ANDROID_HOME)
    return 1
  else if isdirectory(expand("$ANDROID_HOME"))
    return 1
  else
    return 0
  endif
endfunction

function! android#checks#ant()
  let ant_path = system("ant")
  if filereadable(ant_path)
    return 1
  endif

  return 0
endfunction

function! android#checks#valid_project()
  return filereadable("AndroidManifest.xml")
endfunction
