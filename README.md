# local-yokel.nvim

> Work with files close to home.

This plugin is a small plugin that provides a few user commands to edit and
perform other actions relative to the current buffer.

## Installation

Install with your favorite package manager (e.g.
[lazy.nvim](https://github.com/folke/lazy.nvim)).

```lua
{
  "mskelton/local-yokel.nvim"
  config = function()
    require('local-yokel').setup()
  end
}
```

## Usage

### `:E`

This command is identical to `:edit` with the exception that it is relative to
the current buffer directory. This makes it easier to edit files in the current
directory.

### Relatives

The `local-yokel.relatives` module provides functions for quickly navigating
between related files in a directory. This is especially helpful when navigating
to "sibling" files or files that have the same filename, but different
extensions. For example, `MyComponent.tsx` and `MyComponent.graphql` or
`cmd.go` and `cmd_test.go`.

To navigate to sibling files, use the following commands

```lua
require('local-yokel.relatives').next_sibling()
require('local-yokel.relatives').prev_sibling()
```

By dropping `_sibling` from the function name, you can navigate between files
in the current directory. This is similar to `]f` and `[f` from tpope's
[vim-unimpaired](https://github.com/tpope/vim-unimpaired), but it will cycle
around when it reaches the start or end of the current directory.

```lua
require('local-yokel.relatives').next()
require('local-yokel.relatives').prev()
```
