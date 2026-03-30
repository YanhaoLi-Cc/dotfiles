# tmux 配置

基于 vim 风格的 tmux 优化配置。

## 安装

```bash
# 通过 dotfiles installer
bash install.sh

# 或手动 symlink
ln -sf "$(pwd)/tmux/tmux.conf" ~/.tmux.conf
tmux source-file ~/.tmux.conf
```

## 配置概览

| 项目 | 值 | 说明 |
|------|-----|------|
| prefix | `Ctrl+b` | 所有 prefix 快捷键的前置键 |
| escape-time | 10ms | 消除 vim 中 Esc 延迟 |
| history-limit | 50000 | 滚动回看行数 |
| base-index | 1 | 窗口/面板从 1 开始编号 |
| mode-keys | vi | 复制模式使用 vim 键位 |
| mouse | on | 支持鼠标点击、滚动、拖拽 |
| renumber-windows | on | 关闭窗口后自动重排编号 |
| true color | on | 256 色 + true color 支持 |
| focus-events | on | 支持 vim autoread |
| 主题 | One Dark | 深色主题配色 |

## 快捷键

> prefix 的使用方式：先按 `Ctrl+b` 松手，再按后续键。

### 分屏

| 快捷键 | 操作 |
|--------|------|
| `prefix` `\` | 垂直分屏（左右） |
| `prefix` `-` | 水平分屏（上下） |
| `prefix` `x` | 关闭当前面板 |
| `exit` | 在面板中输入也可关闭 |

### 面板导航（vim 方向键）

| 快捷键 | 操作 |
|--------|------|
| `prefix` `h` | 切换到左侧面板 |
| `prefix` `j` | 切换到下方面板 |
| `prefix` `k` | 切换到上方面板 |
| `prefix` `l` | 切换到右侧面板 |

### 调整面板大小

| 快捷键 | 操作 |
|--------|------|
| `prefix` `H` | 向左扩展 5 格 |
| `prefix` `J` | 向下扩展 5 格 |
| `prefix` `K` | 向上扩展 5 格 |
| `prefix` `L` | 向右扩展 5 格 |

> 大写 H/J/K/L 支持按住重复（repeat），不需要反复按 prefix。

### 窗口管理

| 快捷键 | 操作 |
|--------|------|
| `prefix` `c` | 新建窗口 |
| `Alt+1` ~ `Alt+9` | 直接切换到对应窗口（无需 prefix） |

### 复制模式

| 快捷键 | 操作 |
|--------|------|
| `prefix` `v` | 进入复制模式 |
| `v` | 开始选择（复制模式内） |
| `y` | 复制选中内容并退出 |
| `Ctrl+v` | 切换矩形选择 |
| `q` | 退出复制模式 |

> 复制模式下支持 vim 移动键：`h/j/k/l`、`w/b`、`/` 搜索、`n/N` 跳转等。

### 其他

| 快捷键 | 操作 |
|--------|------|
| `prefix` `r` | 重载配置文件 |
