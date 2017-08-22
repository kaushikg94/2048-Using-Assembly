
# Nios-2 Assembly Implementation of 2048 Game

This project was made by [Henry Chen](https://github.com/Nothingtop) and [Gokul Kaushik](https://github.com/kaushikg94) for the ECE243 course's group project requirements. The document for the requirements is available [here](Documents/ProjectProposalForm.docx).

## The Original Game

### Gabriel Cirulli 
The original 2048 game was developed by [Gabriele Cirulli](<http://gabrielecirulli.com>). It is playable [here](<http://gabrielecirulli.github.io/2048/>).

### Game Play
The game is fairly intutive to play. I suggest you go to the link above and play it before reading this. It will make understanding what's written below easier.

1. The game consists of a 4-by-4 block grid i.e. 16 blocks. In the begining, one of the bottom most blocks is given the number 2. 
2. By using the keyboard keys to move up, down, left or right, the block moves in given direction. 
3. Every move generates a new block into the grid (in the begining, it is a 2 and as the game progresses it becomes random). 
4. Everytime you move two blocks of equal value onto each other they merge to form the sum of their values i.e. a 2 and 2 become a 4, a 4 and 4 become an 8 and so on. 
5. The victory condition is to keep merging the blocks until you get 2048 (which is the 11th power of 2). 
6. The loss condition is when the grid is filled up (i.e. 16 slots), no more merge moves are possible, and the number 2048 is not on the grid.

## My Implementation

We implemented the game described above using the following hardware: 

1. Altera DE-2 Board 
2. USB (JTAG UART) Keyboard
3. VGA Monitor
4. Speakers

The software used was: 

1. Altera Quartus
2. Altera University Monitor Program

The project's code was written in: 

1. Nios-2 Assembler (around 90% of the program) 
2. C (for the entry point and the `rand()` function)

It would have been less time consuming to write the enire project using C. However, ECE243 is a course about how low level assemblers work. Therefore the marking scheme prioritizes using Assembly code.

### I/O Visualization

A diagram of the visualization can be found [here](documents/io_diagram.jpg).

In summary, the outputs from the DE2 are: 

1. VGA Monitor
2. Speakers

the inputs to the DE2 are: 

1. Computer that runs the Altera University Monitor Program
2. Keyboard

### Setup

### Demonstration
