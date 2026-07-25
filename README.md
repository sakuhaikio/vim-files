# Vim Configuration README

Compact reference for all custom keybindings and commands in this Vim configuration.

---

# Leader Key

| Key        | Meaning |
| ---------- | ------- |
| `<leader>` | Space   |

---

# Search and Navigation

| Key               | Action                   |
| ----------------- | ------------------------ |
| `<leader><space>` | Clear search highlight   |
| `<leader>p`       | Open `:Files`            |
| `<leader>g`       | Open `:Rg`               |
| `gd`              | Go to definition         |
| `gD`              | Go to declaration        |
| `gy`              | Go to type definition    |
| `gi`              | Go to implementation     |
| `gr`              | Show references          |
| `K`               | Show hover documentation |
| `Ctrl+o`          | Jump back (built-in Vim) |

---

# Buffers

| Key          | Action                |
| ------------ | --------------------- |
| `<leader>bn` | Next buffer           |
| `<leader>bp` | Previous buffer       |
| `<leader>bd` | Delete current buffer |
| `<leader>bl` | List buffers          |

---

# coc.nvim

| Key                | Action                   |
| ------------------ | ------------------------ |
| `<leader>rn`       | Rename symbol            |
| `<leader>f`        | Format current buffer    |
| `Visual <leader>f` | Format selection         |
| `[g`               | Previous diagnostic      |
| `]g`               | Next diagnostic          |
| `<leader>o`        | Open symbol outline      |
| `Tab`              | Next completion item     |
| `Shift-Tab`        | Previous completion item |

---

# NERDTree

| Key      | Action          |
| -------- | --------------- |
| `Ctrl+n` | Toggle NERDTree |

---

# C / C++ Helpers

| Key      | Action                    |
| -------- | ------------------------- |
| `Ctrl+h` | Switch header/source file |

Supported extensions:

```text
.cpp .cc .c <-> .hpp .hh .h
```

---

# Terminal Mode

| Key   | Action             |
| ----- | ------------------ |
| `Esc` | Exit terminal mode |

---

# Insert Mode Tweaks

| Key      | Action           |
| -------- | ---------------- |
| `Ctrl+c` | Exit insert mode |

---


---

# Wrapped Lines

| Key | Action |
| --- | --- |
| `j` | Move by visual line when `wrap` is enabled, otherwise by logical line |
| `k` | Move by visual line when `wrap` is enabled, otherwise by logical line |

---

# WSL

| Key | Action |
| --- | --- |
| `<leader><leader>` | Remove Windows carriage returns (`^M`) from the current file |

# Quickfix Window

| Key     | Action                       |
| ------- | ---------------------------- |
| `Enter` | Open item and close quickfix |
| `q`     | Close quickfix window        |

---

# Custom Commands

| Command      | Action                          |
| ------------ | ------------------------------- |
| `:SwitchHS`  | Switch header/source file       |
| `:FixFormat` | Remove Windows carriage returns |

---

# Plugins

| Plugin     | Purpose                |
| ---------- | ---------------------- |
| `coc.nvim` | LSP and autocompletion |
| `NERDTree` | File tree              |
| `fzf.vim`  | Fuzzy finder           |
| `ripgrep`  | Fast project search    |
| `fd` / `fdfind` | Fast file discovery for `:Files` (hidden files included, common build directories excluded) |

---

# Typical Workflow

| Action               | Shortcut     |
| -------------------- | ------------ |
| Open file            | `<leader>p`  |
| Search project       | `<leader>g`  |
| Go to definition     | `gd`         |
| Jump back            | `Ctrl+o`     |
| Rename symbol        | `<leader>rn` |
| Format code          | `<leader>f`  |
| Switch header/source | `Ctrl+h`     |
