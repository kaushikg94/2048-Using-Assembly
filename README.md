# Nios 2 Assembly Implementation of 2048 Game

## Introduction to 2048
### The Original Game
#### Gabriel Cirulli 
The original 2048 game was developed by Gabriel Cirulli from Gerogia Tech. Credits to him for the **entire** idea.
#### Game Play
##### Idea
The original game, playable here () is based on the idea that you can merge two blocks which have the same number.

The resulting block will be the sum of two blocks (since they are equal, it will form a block with the value of double the original number).

The blocks start with the number 2 and merges will therefore result with blocks that are numbers of two.

All merges happen inside a 4-by-4 block region (a 16 blocks^2 region).

The AI will input a new block every turn in a random spot dictated by previous movement. 

All merges take place by moving up, down, left or right. **All** the blocks on screen will move in that direction.

##### Win Condition
To win, one must merge enough blocks to get to the 2048 block.
##### Lose Condition
To lose, the 16 block^2 area must be filled with blocks in a position where one is unable to make a merge.
