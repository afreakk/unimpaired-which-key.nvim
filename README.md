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
        wk.add(require("unimpaired-which-key"))
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
        wk.add(require("unimpaired-which-key"))
    end
    },
})
```

If you prefer another method, no problem - this plugin is designed to simply provide you with helpful which-key compatible tables.

## Details

`unimpaired-which-key` gives you a table which can be passed to the `wk.add()` function, and that's all it does

## Caveat

Because (I think) vim-unimpaired binds using `<plug>` weird stuff, `vim.o.timeoutlen` has to expire, before you move on to submenus, like `yo`, `]o`, for those sub-menus to show in which-key.  
The mappings will still work if you don't wait, but if you do `yo` before `vim.o.timeoutlen` has expired, you won't see any which-key menu. ¯\_(ツ)\_/¯

Also, for some reason, if you lazy-load vim-unimpaired on `keys = { "[", "]", "y", "=", "<lt>", ">" }` for instance, vim-unimpaired doesn't work ¯\_(ツ)\_/¯
