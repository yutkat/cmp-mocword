# cmp-mocword

[mocword](https://github.com/high-moctane/mocword) completion source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).

## Requirements

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [mocword](https://github.com/high-moctane/mocword)

## Installation

Use your package manager of choice. For example [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'yutkat/cmp-mocword'
}
```

## Setup

```lua
require('cmp').setup({
  sources = {
    { name = 'mocword' }
  }
})
```
