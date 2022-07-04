# My Sofle Keymap

This folder is my QMK config for my Sofle ortho split keyboard.

This folder should be symlinked to `~/qmk_firmware/keyboards/sofle/keymaps/my-sofle-layout`.

## Usage

Modify keymap in `keymap.c`.

Run `qmk compile -kb sofle -km my-sofle-layout` to compile.

Run `qmk flash -kb sofle -km my-sofle-layout` to flash to boards. Flash boards one at a time while not connected via TRRS.

## Default keymap for Sofle Keyboard

![SofleKeyboard default keymap](https://github.com/josefadamcik/SofleKeyboard/raw/master/Images/soflekeyboard.png)
![SofleKeyboard adjust layer](https://github.com/josefadamcik/SofleKeyboard/raw/master/Images/soflekeyboard_layout_adjust.png)

Layout in [Keyboard Layout Editor](http://www.keyboard-layout-editor.com/#/gists/76efb423a46cbbea75465cb468eef7ff) and [adjust layer](http://www.keyboard-layout-editor.com/#/gists/4bcf66f922cfd54da20ba04905d56bd4)
