Project Title: Mastermind 

How it Works:

The player is prompted with a choice -- 

they can play the game by guessing a computer generated code, 
or they can choose their own code and watch the computer make guesses. 

The game then runs through logic, determining if the colors guessed (by either the computer or human, depending on the determined path) are included somewhere in the generated code array. 

If the color is present, but the guessed color is not matching the index position of the related color in the generated code, the program will give a feedback of "red". 

If the guessed color matches both color and index of that in the generated code array, the program gives a feedback of "black" 

In the case that the color does not match anything in the generated code, the feedback will be "incorrect" 

In addition to this, if the player (or computer) guesses a color more times than it appears in the generated code array, the feedback will be "incorrect" 

based on this feedback, the player will be prompted to make new guesses each round until they either win the game or run out of turns. 

In the computer path, there is logic for the computer to randomly generate new color guesses and move the guesses that get "red" feedback either forward or back one index based on the feedback values of those positions. 

Positions that recieve a "black" feedback remain in place for the following guesses. 

This project was a total joy to work on. I still intend to work on some of the logic for the computer. I noticed that, if the feedback for index position 0 is "red" and feedback for index position 1 is "black" the color guess for 0 will be randomized, and that initial guess will not be moved into a different position in the next guess. The computer still typically makes its way back around to finding that color, but I would like to implement logic to take care of this. In addition to that, the computer logic seems to generate all guesses as one color for educated guess. While that actually may be a pretty decent strategy, it was not the intended result. I was trying to get it to randomize the color for each index position individually. One other improvement I am looking to make to the project is the breakpoints and phrazes I use to make the experience more fluid while going through the computer path. There are likely other improvements to make, but for now this is the project! I had so much fun building out this Ruby game! 