bAutoTrash
==========

A World Of Warcraft addon that automatically trashes items based on input or a defined list.

The addon can handle both text input and item links (from shift clicking an item in your inventory).

Usage instructions:
-------------------

* /trash **item name or item link** *- to trash items based on input*
* /trash [auto] on/off *- to toggle whether to automatically trash items on pickup or not*
* /trash [all] *- to trash all items defined in the AutoTrash list*
* /trash [add] **item name or item link** *- to add an item to the AutoTrash list*
* /trash [remove] **item name or item link** *- to remove an item from the AutoTrash list*
* /trash [list] *- to list all items in the AutoTrash list*
* /trash [clear] *- to remove all items from the AutoTrash list*
* /trash [value] [number][c/s/g]*- to automatically trash grey items with a value below [number][c/s/g] (requires /trash auto on)*

Examples:
---------

* /trash Bear Meat *(removes all items with this name)*
* /trash add [Bear Meat] *(adds an item from an item link to the AutoTrash list)*
* /trash all *(trashes all items in your inventory based on the AutoTrash list)*
* /trash value 1s *(will automatically trash all grey items with a value below 1 silver with /trash auto on enabled*