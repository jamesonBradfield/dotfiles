# Simple Motions.

- Try `gg` move to first line in file.
- Try `G` move to last line in file.
- Try `$` in normal mode to move your cursor to the end of this line.
- Try `^` in normal mode to move your cursor to the first character of this line.
- Try `i` in normal mode to enter insert mode at your cursor.
- Try `I` to move to the beginning of the line AND enter insert mode.
- Try `a` to move to the end of said character and insert.
- Try `A` to move to the end of the line AND enter insert mode.

# Motion Modifiers (can be chained with advanced motions)

- Try `b` to move to the beginning of the previous word.
- Try `B` to move to the beginning of the previous word(SPACE-separated WORDS).
- Try `w` to move to the beginning of the next word.
- Try `W` to move to the beginning of the next word(SPACE-separated WORDS)
- Try `e` to move to the end of the next word.
- Try `E` to move to the end of the next word(SPACE-separated WORDS)
- Try `1-9` to repeat IE: 4j moves down 4 lines!

# Advanced motions (do nothing when alone easy to press and mess up)

- Try `d` to enter delete "mode"
- Try `c` to enter change "mode" (deletes the motion target and drops you straight into Insert mode).
- Try `v` in normal mode to enter visual mode at your cursor.
- Try `V` in normal mode to enter visual-Line mode at your cursor.
- Try `<c-v>` in normal mode to enter visual-block mode at your cursor.

# putting it all together!

- Try `V4jy` Enter Visual Line, select the next four lines down, and yank.
- Try `V4j:s/search_string/replace_string/g` Enter command mode `s/old_string/new_string/g` the g let's you select more than the first occurance per line.
- Try `ggVGy` move to top, V-Line, Move to Bottom, Yank (copy whole file).

We need to expose all of these to the Godot Inspector. How do you add [Export] public  to the front of every single line?

``` cs
Node2D playerSpawn;
Node2D enemySpawn;
Node2D lootChest;
Node2D levelExit;
Node2D savePoint;
```

We are migrating to a new input framework. Change Input.bind to Keymap.set across the board.

``` lua
Input.bind("w",      "move_up")
Input.bind("s",      "move_down")
Input.bind("a",      "move_left")
Input.bind("d",      "move_right")
Input.bind("space",  "jump")
```

We forgot the commas at the end of the table entries. The lines are all different lengths. How do you add a comma to the end of every line simultaneously?

``` lua
local server_settings = {
    debug_mode = false
    max_players = 16
    server_name = "Local_Test_Node"
    tick_rate = 60
    enable_cheats = true
}
```
