# local-yokel.nvim

> Work with files close to home.

This plugin is a small plugin that provides a few user commands to edit and
perform other actions relative to the current buffer.

## Installation

Install with your favorite package manager (e.g. [lazy.nvim](https://github.com/folke/lazy.nvim)).

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
