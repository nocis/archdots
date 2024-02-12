1. switch window
   <c-h> <c-l>
   switch buffer
   <H><L>

2. window size
   <c-up,down,left,right>

3. jump
   <c-o> <c-i> jump created by jump actions

4. move
   begin:0, end:$, insert after:a, last word: b, next word:w
   down block:<c-D>, up block: <c-U>
   ^ - jump to the first non-blank character of the line
   $ - jump to the end of the line

5. neotree deletebuffer file
   <leader>: SPACE
   etc. <leader>bp

6. delete
   dd - delete (cut) a line
   2dd - delete (cut) 2 lines
   dw - delete (cut) the characters of the word from the cursor position to the start of the next word
   diw - delete (cut) word under the cursor
   daw - delete (cut) word under the cursor and the space after or before it
   :3,5d - delete lines starting from 3 to 5

7. next line + insert mode: o
   before line + insert mode: O,

8. copy from register (ie. *) : "*p

9. search repalce: :%s/old/new/c
   Once you selected the lines to replace, type your command:

   :s/<search_string>/<replace_string>/g
   You'll note that the range '<,'> will be inserted automatically for you:

   :'<,'>s/<search_string>/<replace_string>/g
   Here '< simply means first highlighted line, and '> means last highlighted line.

   Use \r instead of \n for new line

11. LSP
    <leader>cl Lsp Info
    gd Goto Definition
    gr References
    gD Goto Declaration
    gI Goto Implementation
    gy Goto T[y]pe Definition
    K Hover
    <leader>cr Rename

12. buffer
    <leader>bd delete current buffer

13. mark
    open jump list: `
    add mark a: ma (mb mc ....)
    delete mark :delmarks a

14. print current file path: <c-g>

15. comment out:
    gc

16. hjkl: better way to move cursor，10j：down 10 lines
    HL : move tab, K: hover J: trailing line

17. Search and highlight : /
    keep search result and back to normal: <enter>
    Escape and clear hlsearch: <esc>
    n for next N for back
    * for search current

19. help
    Ctrl-] to follow the link

20. search
    type /
    type search term e.g. "var"
    press enter
    for next instance press n (for previous N)
    press `n`. If you want to search backward for the previous occurrence, press `N`.

21. buffer
    [b: prev buffer
    ]b: next buffer

22. Rename
    <leader>cr : rename prompt

23. :qa quit all windows for quick open next time

24. f find and jump, i will insert before search character
    t find and jumo, i will insert after search character
    f or t will repeat(next match)

25. completion
    <c-e> stop menu!

26. format
    confirm set .prettierrc

27. LSP
    nvim-lsp set root dir for servers

28. eslint
    package eslint install as eslint library

29. javascript lint and auto import
    required js/tsconfig.json
    checkJs: true
    
30. for vue lsp
    install typescript
    @vue/language-server install default by mason


31. add missing import
    feature from typescript LSP
    need types exposed via tsconfig(all installed node modules by default)
    Lsp and add import also works with out type module in package.json"

32. lsp debug
    restart and see lsplog

33. package.json
    type module accept export from js

34. visual
    veeeee, incremental select words!!!
    bve, back to start,visual,eeeeeee

35. Press P (uppercase) to paste before your cursor.

36. diagnostic
    <leader>sd: show document diagnostics
    <leader>xx: Document Diagnostics (Trouble) --this is better

37. notifications
    <leader>un	Dismiss all Notifications

38. outline
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
39. mini-bracket
     Using `lower-suffix` and `upper-suffix` (lower and upper case suffix) for a single target the following mappings are created:
    - `[` + `upper-suffix` : go first.
    - `[` + `lower-suffix` : go backward.
    - `]` + `lower-suffix` : go forward.
    - `]` + `upper-suffix` : go last.

- Supported targets (for more information see help for corresponding Lua function):

    | Target                                            | Mappings            | Lua function                 |
    |---------------------------------------------------|---------------------|------------------------------|
    | Buffer                                            | `[B` `[b` `]b` `]B` | `MiniBracketed.buffer()`     |
    | Comment block                                     | `[C` `[c` `]c` `]C` | `MiniBracketed.comment()`    |
    | Conflict marker                                   | `[X` `[x` `]x` `]X` | `MiniBracketed.conflict()`   |
    | Diagnostic                                        | `[D` `[d` `]d` `]D` | `MiniBracketed.diagnostic()` |
    | File on disk                                      | `[F` `[f` `]f` `]F` | `MiniBracketed.file()`       |
    | Indent change                                     | `[I` `[i` `]i` `]I` | `MiniBracketed.indent()`     |
    | Jump from jumplist inside current buffer          | `[J` `[j` `]j` `]J` | `MiniBracketed.jump()`       |
    | Location from location list                       | `[L` `[l` `]l` `]L` | `MiniBracketed.location()`   |
    | Old files                                         | `[O` `[o` `]o` `]O` | `MiniBracketed.oldfile()`    |
    | Quickfix entry from quickfix list                 | `[Q` `[q` `]q` `]Q` | `MiniBracketed.quickfix()`   |
    | Tree-sitter node and parents                      | `[T` `[t` `]t` `]T` | `MiniBracketed.treesitter()` |
    | Undo states from specially tracked linear history | `[U` `[u` `]u` `]U` | `MiniBracketed.undo()`       |
    | Window in current tab                             | `[W` `[w` `]w` `]W` | `MiniBracketed.window()`     |
    | Yank selection replacing latest put region        | `[Y` `[y` `]y` `]Y` | `MiniBracketed.yank()`       |





  40. edit multiple lines
A:
Move the cursor to the n in name.
Enter visual block mode (Ctrlv).
Press j three times (or 3j) to jump down by 3 lines; G (capital g) to jump to the last line
Press I (capital i).
Type in vendor_. Note: It will only update the screen in the first line - until Esc is pressed (6.), at which point all lines will be updated.
Press Esc.

B:
Move the cursor where you want to start
Press i
Type in the prefix you want (e.g. vendor_)
Press esc.
Press j to go down a line
Type . to repeat the last edit, automatically inserting the prefix again
Alternate quickly between j and .


41. folding
    zc fold za unfold

42: command line
    <C-n> <C-p>
