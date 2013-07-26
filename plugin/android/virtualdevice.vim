function! android#virtualdevice#create(name,target,options)
  let keyset = keys(a:options)
  let argStr = ""
  for keyName in keyset
    let argStr+= " --" . keyName . " " a:options[keyName]
  endfor

  echo system("android -v create avd --name " . a:name . " --target " . shellescape(a:target) . argStr)
endfunction

function! android#virtualdevice#rename(name,newName,path)
  let path = ""
  let newName = ""
  if !empty(a:path) | path = "--path " . a:path | endif
  if !empty(a:newName) | newName = "--rename " . a:newName | endif

  echo system("android -v move avd --name " . a:name . " " . a:path . " " . newName)
endfunction

function! android#virtualdevice#update(name)
  echo system("android -v update avd " . a:name)
endfunction

function! android#virtualdevice#delete(name)
  echo system("android -v delete avd " . a:name)
endfunction

function! android#virtualdevice#get_all()
  return split(system("android -v list avd -c"), "\n")
endfunction

function! android#virtualdevice#invoke(name, options)
  let keyset = keys(a:options)
  let argStr = ""
  for keyName in keyset
    let argStr+= " --" . keyName . " " a:options[keyName]
  endfor

  echomsg "[android] Starting emulation of virtual device '" . name . "'..."
  system("emulator @" . name . argStr . " &")
endfunction
