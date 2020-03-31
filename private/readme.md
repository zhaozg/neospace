Private
=======

The *private* directory can be considered as a single layer or a set of layers. If you have a heavy customized configuration, it is nice to organize them here.

For instance, according to the layer structure in neospace, you could put your personal plugins in `packages.vim` and configuration in `init.vim` or `config.vim`, which will be loaded on startup.

```
private/
├── README.md
├── init.vim        # active before plugins load
├── packages.vim    # just loading plugins
└── config.vim      # active after plugins load
```

