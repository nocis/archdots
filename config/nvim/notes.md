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
   J: line join to delete empty line and space
   kJ: go back, then join next line for miss CR

8. next line + insert mode: o
   before line + insert mode: O,

9. copy from register (ie. *) : "*p
   yaw:yank around word

10. search repalce: :%s/old/new/c
   Once you selected the lines to replace, type your command:

   :s/<search_string>/<replace_string>/g
   You'll note that the range '<,'> will be inserted automatically for you:

   :'<,'>s/<search_string>/<replace_string>/g
   Here '< simply means first highlighted line, and '> means last highlighted line.

   Use \r instead of \n for new line

   :%s/\(= \)\@<!len(matrix\(\[0\]\)*)/n/g
   len(matrix) and len(matrix[0]) -> n
   but without prefix "= " 

11. LSP
    <leader>cl Lsp Info
    gd Goto Definition
    gr References
    gD Goto Declaration
    gI Goto Implementation
    gy Goto T[y]pe Definition
    K Hover
    K again: focus in hover window
    insert mode <c-k>: Signature Help
    <leader>cr Rename

13. buffer
    <leader>bd delete current buffer
    <leader>, list all buffer to switch

15. mark
    open jump list: `
    add mark a: ma (mb mc ....)
    delete mark :delmarks a

16. print current file path: <c-g>

17. comment out:
    gc

18. hjkl: better way to move cursor，10j：down 10 lines
    HL : move tab, K: hover J: trailing line

19. Search and highlight : /
    keep search result and back to normal: <enter>
    Escape and clear hlsearch: <esc>
    n for next N for back
    * for search current

20. help
    Ctrl-] to follow the link

21. search
    type /
    type search term e.g. "var"
    press enter
    for next instance press n (for previous N)
    press `n`. If you want to search backward for the previous occurrence, press `N`.

22. buffer
    [b: prev buffer
    ]b: next buffer

23. Rename
    <leader>cr : rename prompt

24. :qa quit all windows for quick open next time

25. f find and jump, i will insert before search character
    t find and jumo, i will insert after search character
    f or t will repeat(next match)

26. completion
    <c-e> stop menu!

27. format
    confirm set .prettierrc

28. LSP
    nvim-lsp set root dir for servers

    keymaps:
<leader>cl	Lsp Info
gd	Goto Definition
gr	References
gD	Goto Declaration
gI	Goto Implementation
gy	Goto T[y]pe Definition
K	Hover
gK	Signature Help
<c-k>	Signature Help
<leader>ca	Code Action
<leader>cA	Source Action
<leader>cr	Rename

29. eslint
    package eslint install as eslint library

30. lsp lint and auto import
    ts/js required js/tsconfig.json
    js need checkJs: true
    tailwind need tailwind.config.js to work
    
32. for vue lsp
    install typescript
    @vue/language-server install default by mason


33. add missing import
    feature from typescript LSP
    need types exposed via tsconfig(all installed node modules by default)
    Lsp and add import also works with out type module in package.json"

34. lsp debug
    restart and see lsplog

35. package.json
    type module accept export from js

36. visual
    veeeee, incremental select words!!!
    bve, back to start,visual,eeeeeee

37. Press P (uppercase) to paste before your cursor.

38. diagnostic
    <leader>sd: show document diagnostics
    <leader>xx: Document Diagnostics (Trouble) --this is better

39. notifications
    <leader>un	Dismiss all Notifications

40. outline
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
41. mini-bracket
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
43: save without format
    :noa w

44：misspell
    ]s will go to the next misspelled word.
    [s will go to the previous misspelled word.
    z= suggests
    zg add to vocabulary

45: multi cursor
    1. / search
    2. go first with n or N
    3. v select the change scope
    4. c change 
    5. esc form insert
    6. go next with n
    7. apply same selection change with .

    1. / search
    2. gn for next and select
    3. c for change
    4. for insert
    5. esc for stop (highlight cleared but search still in record)
    6. n for next search
    7. . for repeat selection and apply last change


46: liveserver for html
    npm live-server


47: ui
<leader>uh: toggle inlay hints

48: selection
vi'  ("select inner single quotes"): To select between the single quotes.
vib ("select inner block") : (...)
viB  :{...}


49 git
$ git remote add github https://github.com/Company_Name/repository_name.git

# push master to github
$ git push github master

# Push my-branch to github and set it to track github/my-branch
$ git push -u github my-branch

# Make some existing branch track github instead of origin
$ git branch --set-upstream other-branch github/other-branch


50: end/begin of file
Go to Top - Double g
Go to Bottom - Shift + g


51: open cursor in browser
gx


52: git hunk
apply: stage this change
reset: discard this change
interactively unstage hunks: git restore --staged -p  CMakeLists.txt
