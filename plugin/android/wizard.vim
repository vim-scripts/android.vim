function! android#wizard#input(message)
  let result = input(message)
  echomsg "
\ "
  return result
endfunction

function! android#wizard#confirm(message)
  echomsg "[android] " . a:message
  response = input("Confirm (yes/no/y/n): ")
  echomsg "
\ "
  if response == "yes" || response == "y" | return 1 | endif
  return 0
endfunction

function! android#wizard#option(message, options)
  echomsg "[android] " . a:message
  let option_names = keys(a:options)

  for option in option_names
    echomsg "* " . option . " - " . a:options[option]
  endfor

  let response = input("Option? ")
  echomsg "
\ "

  if count(keys(a:options), response)
    return response
  else
    return 0
  endif
endfunction

function! android#wizard#pick(message, options)
  echomsg "[android] " . a:message

  for key in a:options
    echomsg "* " . ( index(a:options,key) + 1) . " - " . key
  endfor

  let response = input("Option? ", (index(a:options,g:android_default_target) + 1))
  echomsg "
\ "

  if response >= 0 && response < len(a:options)
    return a:options[response]
  else
    return 0
  endif
endfunction
