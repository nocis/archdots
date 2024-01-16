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
    <leader>cl	Lsp Info	
    gd	Goto Definition	
    gr	References	
    gD	Goto Declaration	
    gI	Goto Implementation	
    gy	Goto T[y]pe Definition	
    K	Hover	
    <leader>cr	Rename

11. buffer
    <leader>bd delete current buffer
