function [carPosition1] = moveCar(c1)
% Take the postion of car and add 1 to make it move across the screen
% Make an if statement to move the cars 1 space over, but then say if it goes off the board start back at the beginning?

carPosition1 = [7, 2]

for i = 1:11 
if carPosition1(i, 2) >= carPosition1
    carPosition1 = carPosition1 + 1
else  carPosition1(i, 2) <= carPosition1
    carPosition1 = carPosition1 - 1
end
end