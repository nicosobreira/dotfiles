function! BashOmnifunc(Pattern)
  " Get possible completions from compgen (commands, filenames)
  let l:cmd = 'bash -c "compgen -abck ' . a:Pattern . '"'
  let l:results = split(system(l:cmd), '\n')

  " Add completions for Bash functions (local/global)
  let l:cmd = 'bash -c "declare -F | cut -d" " -f3 | grep -e "^' . a:Pattern . '"'
  let l:functions = split(system(l:cmd), '\n')
  let l:results += l:functions

  " Add completions for Bash variables (local/global)
  let l:cmd = 'bash -c "declare -p 2>/dev/null | grep -o -P "^\s*declare -[^\s]+ \w*' . a:Pattern . '"'
  let l:variables = split(system(l:cmd), '\n')
  let l:results += l:variables

  return l:results
endfunction

setlocal omnifunc=BashOmnifunc
