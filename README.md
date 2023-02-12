# unimpaired-which-key.nvim

**unimpaired-which-key.nvim** is a bridge between [vim-unimpaired](https://github.com/tpope/vim-unimpaired/) and [which-key.nvim](https://github.com/folke/which-key.nvim)

## Features

-   Which-key compatible tables with descriptions of the various vim-unimpaired mappings.

## Installation

Install the plugin with your preferred package manager, and set `tpope/vim-unimpaired` as a dependency like shown below:

#### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require("lazy").setup({
  { "afreakk/unimpaired-which-key.nvim"
    , dependencies = { "tpope/vim-unimpaired" }
    , config = function()
        local wk = require("which-key")
        local uwk = require("unimpaired-which-key")
        wk.register(uwk.normal_mode)
        wk.register(uwk.normal_and_visual_mode, { mode = { "n", "v" } })
    end
    },
})
```

Another options is using it as a dependency of which-key like this:

```lua
require("lazy").setup({
  { "folke/which-key.nvim"
    , dependencies = { "afreakk/unimpaired-which-key.nvim" }
    , config = function()
        local wk = require("which-key")
        wk.setup({
            -- whatever options you got
        })
        local uwk = require("unimpaired-which-key")
        wk.register(uwk.normal_mode)
        wk.register(uwk.normal_and_visual_mode, { mode = { "n", "v" } })
    end
    },
})
```

If you prefer another method, no problem - this plugin is designed to simply provide you with helpful which-key compatible tables.

## Details

`unimpaired-which-key` gives you two tables, and that's all it does

-   `normal_and_visual_mode` contains the decoders/encoders, which can be used in both normal and visual mode
-   `normal_mode` contains the rest of the mappings, and they can only be used in normal mode
