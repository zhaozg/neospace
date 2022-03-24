Private
=======

The *private* directory can be considered as private layers. If you have a heavy customized configuration, it is nice to organize them here.

First you need create `init.lua` in the *private* directory.

```init.lua
local layer = require'neospace.layer'

layer:load('mycode', true)
```
