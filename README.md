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
        wk.add(uwk)
    end
    },
})
```

Another option is using it as a dependency of which-key like this:

```lua
require("lazy").setup({
  { "folke/which-key.nvim"
    , dependencies = { "afreakk/unimpaired-which-key.nvim" }
    , config = function()
        local wk = require("which-key")
        local uwk = require("unimpaired-which-key")
        wk.setup({
            -- whatever options you got
            triggers = vim.list_extend(
                { { "<auto>", mode = "nixsotc" } },
                uwk.triggers
            ),
        })
        wk.add(uwk)
    end
    },
})
```

If you prefer another method, no problem - this plugin is designed to simply provide you with helpful which-key compatible tables.

## Details

`unimpaired-which-key` gives you a table which can be passed to the `wk.add()` function, and that's all it does

## Operator-key conflicts (yo, \<s, >s, =s)

Some vim-unimpaired prefixes start with Vim operator keys (`y`, `<`, `>`, `=`).
which-key v3's `<auto>` trigger won't intercept these because doing so would
break their normal operator behavior (yank, indent, dedent, reindent).

This means sub-menus like `yo` (toggle options) won't appear in the which-key
popup by default. **Do not** add single-character triggers like `y` — that
breaks operator-pending mode entirely.

Instead, this plugin exports `M.triggers` with multi-character trigger
prefixes (`yo`, `<s`, `>s`, `=s`, `[o`, `]o`) that you can merge into your
which-key setup. These let which-key show the popup *after* the full prefix
is typed, so operators still work normally:

```lua
local uwk = require("unimpaired-which-key")
require("which-key").setup({
    triggers = vim.list_extend(
        { { "<auto>", mode = "nixsotc" } },
        uwk.triggers
    ),
})
require("which-key").add(uwk)
```

## Other caveats

Because (I think) vim-unimpaired binds using `<plug>` weird stuff, `vim.o.timeoutlen` has to expire, before you move on to submenus, like `yo`, `]o`, for those sub-menus to show in which-key.
The mappings will still work if you don't wait, but if you do `yo` before `vim.o.timeoutlen` has expired, you won't see any which-key menu. ¯\_(ツ)\_/¯

Also, for some reason, if you lazy-load vim-unimpaired on `keys = { "[", "]", "y", "=", "<lt>", ">" }` for instance, vim-unimpaired doesn't work ¯\_(ツ)\_/¯


  
## Compatibility with `which-key` v2.x

This plugin has been updated to leverage the new APIs added in `which-key` v3. For compatibility with older versions of `which-key`, pin this plugin to the `v0.1` tag.
