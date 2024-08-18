# Private

The _private_ directory can be considered as private layers. If you have a heavy customized configuration, it is nice to organize them here.

First you need create `init.lua` in the _private_ directory.

```init.lua
local layer = require'neospace.layer'

layer:load('mycode', true)
```
