func! s:init_config()
  " Define the default options.
  let default_config = {
\    "android_default_package_path"    :  "com." . $USER,
\    "android_default_project_path"    :  $HOME . "/projects",
\    "android_default_target"          :  "android-18",
\    "android_tags_path"               :  $HOME . ".tags/android-sdk",
\    "android_tags_project_path"       :  ".android.tags",
\    "android_tags_sdk_auto_generate"  :  0,
\    "android_sdk_path"                :  $ANDROID_HOME }

  " Define properties that don't exist.
  for key in keys(default_config)
    if !exists(key)
      exec "if !exists('g:" . key . "') | let g:" . key . "=\"" . default_config[key] . "\" | endif"
    endif
  endfor
endfunc

func! s:init_commands()
  " Add in the Ex commands.
  command! -buffer -nargs=* Android              :echo "[android] Not yet implemented."
  command! -buffer -nargs=0 AndroidProject       :call android#wizard#project#start()<CR>
  command! -buffer -nargs=* AndroidVirtualDevice :call android#wizard#virtualdevice#start()<CR>
  command! -buffer -nargs=* AndroidEmulator      :call android#wizard#virtualdevice#emulator()<CR>
endfunc

if !exists("g:android_plugin_loaded")
  call s:init_commands()
  call s:init_config()
  let g:android_plugin_loaded=1

  let &makeprg="ant"
endif
