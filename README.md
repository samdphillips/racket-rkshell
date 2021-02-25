# rkshell

`rkshell` is a lang that slightly subverts the normal Racket reader.  When the reader reads a term,
```
#{/usr/bin/ssh -l user host.example.com $remote-command}
```
it turns it into
```
(#%rkexec /usr/bin/ssh -l user host.example.com $remote-command)
```
The default binding of `#%rkexec` is a macro that in this case expands to,
```
(apply (rkexec-runner) "/usr/bin/ssh" "-l" "user" "host.example.com" remote-command)
```
`rkexec-runner` is a parameter that by default is bound to [`system*`][system-doc-ref].  Because it 
is a parameter you can make it do anything you want really.

[system-doc-ref]: (https://docs.racket-lang.org/reference/subprocess.html?#%28def._%28%28lib._racket%2Fsystem..rkt%29._system%2A%29%29)
