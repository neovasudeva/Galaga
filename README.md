# Galaga
A SystemVerilog (hardware) implementation of Galaga. To be used for ECE 385 final project.

## Synopsis
This project is a very basic implementation of Galaga in SystemVerilog. It uses a static background 
and only uses on-chip memory to store RGB values of sprites and ASCII-based fonts. The use of NIOS II is 
very low (only to obtain keyboard input from USB). At a high level, much of the game is 
implemented with pure logic while the progression through the game is controlled via a state machine.

## Controls
A = Move left <br>
D = Move write <br>
Space = Shoot <br>
Enter = Move to next screen <br>
