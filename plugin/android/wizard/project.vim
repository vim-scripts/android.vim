function! android#wizard#project#start()
  let action = android#wizard#option("Select a project action from the options below.", {
\ "create"  : "Create a new Android project.",
\ "update"  : "Update information about an Android project.",
\ "build"   : "Build an existing Android project.",
\ "install" : "Install an existing Android project."
\ })

  if !empty(action)
    exec "call android#wizard#project#" . action . "()"
  else
    echoerr "[android] Invalid project action provided."
  endif
endfunction

function! android#wizard#project#pick_type()
  return android#wizard#option("Select a type of project from the options below.", {
\ "app"    : "An application project.",
\ "lib"    : "A library project.",
\ "test"   : "A project for a test package.",
\ "uitest" : "A project for a UI test package."
\ })
endfunction

function! android#wizard#project#build()
  let mode = android#wizard#pick("Select which mode you'd like to build.", [ "debug", "release"])

  if mode == "debug"
    call android#build#debug()
  else if mode == "release"
    call android#build#release()
  endif
endfunction

function! android#wizard#project#install()
  let mode = android#wizard#pick("Select which mode you'd like to install.", [ "debug", "release"])

  if mode == "debug"
    call android#install#debug()
  else if mode == "release"
    call android#install#release()
  endif
endfunction

function! android#wizard#project#create()
  let type = android#wizard#project#pick_type()

  if empty(type)
    echoerr "[android] Invalid project type project provided."
    return 0
  endif

  let path = input(type . " project root path: ", g:android_default_project_path, "dir") 
  echomsg "
\ "
  let target = android#wizard#pick("Select a Android version to target.", android#util#get_targets())

  if type == "app"
    call android#wizard#project#create_app(path, target)
  else if type == "lib"
    call android#wizard#project#create_lib(path, target)
  else
    echoerr "[android] Project building of '" . type . "' not supported."
  endif
  return 0
endfunction

function! android#wizard#project#update()
  let type = android#wizard#project#pick_type()

  if empty(type)
    echoerr "[android] Invalid project type project provided."
    return 0
  endif

  let target = android#wizard#pick("Select a Android version to target.", android#util#get_targets())

  if type == "app"
    call android#wizard#project#update_app(path, target)
  else if type == "lib"
    call android#wizard#project#update_lib(path, target)
  else
    echoerr "[android] Project updating of '" . type . "' not supported."
  endif
  return 0
endfunction


" TODO: Do some error-checking on the output.
function! android#wizard#project#create_app(path, target)
  let package = input("Package name? ", g:android_default_package_path)
  echomsg "
\ "
  let activity = input("Default Activity class name?", "MainActivity")
  echomsg "
\ "

  let name = android#wizard#input("[android] (optional) Project Name? ")
  if !empty(name) | name = " --name " . name | endif

  echo system("android create project -s --target \"" . a:target . "\" --activity " . activity . " --package " . package . " --path " . a:path . name)
endif
return 0
endfunction

" TODO: Do some error-checking on the output.
function! android#wizard#project#create_lib(path, target)
  let package = input("Package name? ", g:android_default_package_path)
  echomsg "
\ "
  let name = android#wizard#input("[android] (optional) Project Name? ")
  if !empty(name) | name = " --name " . name | endif
  echomsg "
\ "
  if !empty(name) | name = " --name " . name | endif

  echo system("android create lib-project -s --target \"" . a:target . " --package " . package . " --path " . a:path . name)
endif
return 0
endfunction

" TODO: Do some error-checking on the output.
function! android#wizard#project#update_app(path, target)
  let name = android#wizard#input("[android] (optional) Project Name? ")
  if !empty(name) | name = " --name " . name | endif
  echo system("android update project -s " . a:target . " --path " . a:path . name)
endfunction

" TODO: Do some error-checking on the output.
function! android#wizard#project#update_lib(path, target)
  let name = android#wizard#input("[android] (optional) Project Name? ")
  if !empty(name) | name = " --name " . name | endif
  echo system("android update lib-project -s " . a:target . " --path " . a:path . name)
endfunction
