---
description: >
  Set or get a i3 variable
updated:       2021-05-26
version:       0.050
author:        budRich
repo:          https://github.com/budlabs/i3ass
created:       2017-12-22
dependencies:  [bash, i3]
see-also:      [bash(1), i3(1)]
synopsis: |
    set VARNAME [VALUE] [--json JSON]
    get VARNAME [--json JSON]
    --help|-h
    --version|-v
...

# long_description

`i3var` is used to get or set a "variable" that is bound to the current i3wm session. 
The variable is actually the mark on the **root container**.

`set`  \[VALUE\]  
If *VARNAME* doesn't exist,
a new window and mark will be created. 
If *VARNAME* exists, it's value will be replaced with *VALUE*.  
If *VALUE* is not defined, 
*VARNAME* will get unset (the mark is removed).  

`get`  
if *VARNAME* exists, 
its value will be printed to **STDOUT**.  
