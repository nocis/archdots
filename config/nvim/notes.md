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

10. LSP
    <leader>cl Lsp Info
    gd Goto Definition
    gr References
    gD Goto Declaration
    gI Goto Implementation
    gy Goto T[y]pe Definition
    K Hover
    <leader>cr Rename

11. buffer
    <leader>bd delete current buffer

12. mark
    open jump list: `
    add mark a: ma (mb mc ....)
    delete mark :delmarks a

13. print current file path: <c-g>

14. comment out:
    gc

15. hjkl: better way to move cursor，10j：down 10 lines
    HL : move tab, K: hover J: trailing line

16. Search and highlight : /
    keep search result and back to normal: <enter>
    Escape and clear hlsearch: <esc>

17. help
    Ctrl-] to follow the link

18. search
    press `n`. If you want to search backward for the previous occurrence, press `N`.

19. buffer
    [b: prev buffer
    ]b: next buffer

20. Rename
    <leader>cr : rename prompt

21. :qa quit all windows for quick open next time
