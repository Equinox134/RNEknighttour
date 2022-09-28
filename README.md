# RNEknighttour
basic R&amp;E 1-2 knight tour w/ ant colony optimization

## How To

How each script works

### tspACO

The 5 scripts in tspACO are processing scripts for visualizing the travelling salesman problem using ant colony optimization.

To use it, put the 5 scripts in the same folder, then run the code. This will make a window appear with stuff written on it. 
The left part of the window will show the pheromone map, and the right will show the shortest path that has been found. 
The opacity of a line on the pheromone map is relative to the density of the pheromone.

Controls:
* Clicking on the left part creates a new point
* Enter will start the program
* Pressing Enter while the program is running stops the program, and you can add more points
* the r key clears the screen

Value meanings:
* \# of Ants: the number of ants that have been sent
* \# of Iterations: the number of iterations the program has done
* Current Minimum Distance: the distance of the shortest path that has been found
* phW: the weight of the pheromone when an ant choses a path
* distW: the weight of the distance when an ant choses a path
* phS: how much pheromone is being placed for one ant
* ec: how much pheromone is evaporated for each iteration

### knight_tour_Warnsdorff_s_rule

knight_tour_path.pde in this folder is a processing script for visualizing the knights tour using Warnsdorff's rule. The chessboard isn't perfect. 
You must change the variables inside the script to change parameters.

Important Variables:
* BoardX and BoardY are the horizontal and vertical length of the board
* X and Y are the starting position of the knight tour

knight_tour_Warnsdorff_s_rule.pde in this folder is a processing script for calculating the success rate of Warnsdorff's rule. This is not finished.

### Knight_Tour_ACO

These are C++ scripts for finding the knight tour in various ways:
* aco.cpp: using ant colony optimization w/ Warnsdorff's rule as a paths desirability
* acowarnsdorff.cpp: using Warnsdorff's rule with ACO pheromone as a tiebreaker
* warnsdorff.cpp: using Warnsdorff's rule only
