#! /bin/bash
# Repopulate font list
sudo fc-cache -rfv

# Repopulate for latex
# luaotfload-tool --cache=erase
# sudo texhash
