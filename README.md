
# Nios 2 Assembly Implementation of 2048 Game
----------------------------------------------
## The Original Game
=====================
### Gabriel Cirulli 
The original 2048 game was developed by [**Gabriele Cirulli**](<http://gabrielecirulli.com>). Credits to him for the **entire** game idea.
### Game Play
The original game, (playable [**here**](<http://gabrielecirulli.github.io/2048/>)) is based on the idea of merging two blocks of equal number to form a third block which is the sum of the two (which is 2x the block as they are equal). The blocks start at 2 and all merges will result in block values to the power of two. The game is limited by a 4-by-4 matrix where each block takes a 1-by-1 space in the matrix. Hence there can only be 16 blocks in the game at most. Every move (up, down, left or right) that is made by the player results in the shift of **all** the blocks in that direction. Every move by the player results in a block being added by the AI. Typically blocks are added in the reverse direction (e.g. if you move left, the AI tends to put a block on the rightmost sqaure),but this is subject to there being space in that direction. To win, one must keep playing till the "2048" block is reached (hence the name). One looses when there are no directional moves available with the given blocks (i.e. the board is full and you can't merge anything).

## My Implementation
=====================
### Tools and Languages
Languages Used:

1. Nios-II Assembly Language ([guide](https://www.altera.com/en_US/pdfs/literature/hb/nios2/n2cpu_nii51017.pdf)) - 90% of the program
2. C-Language - Entry point, `rand()` Function

Devices Used: 

1. Altera DE2 Board
2. Monitor
3. Speakers
4. JTAG-UART Keyboard

### I/O Visualization



