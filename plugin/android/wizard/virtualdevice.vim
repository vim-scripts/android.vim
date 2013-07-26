function! android#wizard#virtualdevice#start()
  let action = android#wizard#option("Select a virtual device action from the options below.", {
\ "create"    : "Create a new Android virtual device.",
\ "update"    : "Updates an existing Android virtual device.",
\ "delete"    : "Deletes an existing Android virtual device.",
\ "move"      : "Moves and optionally rename an existing Android virtual device.",
\ "list"      : "List all Android virtual devices.",
\ "emulator"  : "Starts a Android virtual device."
\ })

  if !empty(action)
    exec "call android#wizard#virtualdevice#" . action . "()"
  else
    echoerr "[android] Invalid AVD action provided."
  endif
endfunction

function! android#wizard#virtualdevice#list()
  echomsg "[android] Finding AVDs...\n"
  echomsg "[android] " . join(android#virtualdevice#get_all(), "; ")
endfunction

function! android#wizard#virtualdevice#create()
  let name = android#wizard#input("[android] Name of AVD? ")
  echomsg "[android] Collecting targets..."
  let target = android#wizard#pick("[android] Android API version to use? ", android#util#get_targets())
  echomsg "[android] Building AVD '" . name . "'..."

  call android#virtualdevice#create(name, target, {})
endfunction

function! android#wizard#virtualdevice#update()
  let name = android#wizard#input("[android] Name of AVD? ")

  call android#virtualdevice#update(name)
endfunction

function! android#wizard#virtualdevice#delete()
  let name = android#wizard#input("[android] Name of AVD? ")

  call android#virtualdevice#delete(name)
endfunction

function! android#wizard#virtualdevice#move()
  let name = android#wizard#input("[android] Name of AVD? ")
  let newname = android#wizard#input("[android] (optional) New name? ")
  let path = android#wizard#input("[android] (optional) Path? ")

  call android#virtualdevice#delete(name, newname, path)
endfunction

function! android#wizard#virtualdevice#emulator()
  let name = android#wizard#pick("[android] Select a AVD to use: ", android#virtualdevice#get_all())
  if !exists(name)
    call android#virtualdevice#invoke(name, {})
  endif
endfunction
