set nocompatible
set sts=4 sw=4 ai
set notimeout
set expandtab
set exrc

:imap jk <Esc>
:imap kj <Esc>
:imap jj <Esc>jj
:imap kk <Esc>kk

set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
