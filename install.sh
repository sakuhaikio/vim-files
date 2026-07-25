#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

ln -sfn "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"

mkdir -p "$HOME/.vim/colors"
ln -sfn "$SCRIPT_DIR/colors/omateema.vim" \
       "$HOME/.vim/colors/omateema.vim"

mkdir -p "$HOME/.vim/syntax"
ln -sfn "$SCRIPT_DIR/syntax/cpp.vim" \
       "$HOME/.vim/syntax/cpp.vim"

ln -sfn "$SCRIPT_DIR/coc-settings.json" \
       "$HOME/.vim/coc-settings.json"

ln -sfn "$SCRIPT_DIR/.clang-format" \
       "$HOME/.clang-format"

echo "Installation complete."
