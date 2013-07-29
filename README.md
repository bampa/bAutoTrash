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

Examples:
---------

* /trash Bear Meat *(removes all items with this name)*
* /trash add [Bear Meat] *(adds an item from an item link to the AutoTrash list)*
* /trash all *(trashes all items in your inventory based on the AutoTrash list)*

Known issues:
-------------

Using **/trash auto on**: items don't get deleted the first time they're looted. For example:
You have added [Bear Meat] to the AutoTrash list and activated **/trash auto on**. In some (most?) cases
when the [Bear Meat] is looted for the first time, it won't get automatically deleted from your inventory leaving
you with one [Bear Meat] in your inventory. However, the next time you loot a [Bear Meat] both of them will be
deleted.

This is most likely caused by an delay from when the event is fired to when the item is actually ending up
in your inventory.