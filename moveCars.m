function [carPosition1] = moveCar(c1)
% Take the postion of car and add 1 to make it move across the screen
% Make an if statement to move the cars 1 space over, but then say if it goes off the board start back at the beginning?

carPosition1 = [7, 2]
c1 = 11

for i = 1:11
    topL(carPosition1(1), carPosition1(2)) = 1;
        carPosition(2) = carPosition1(2) + 1;
        topL(carPosition(1), carPosition(2)) = 2;
end 
% for i = 1:11
%     if carPosition1(7, i) < c1
%     carPosition1 = i + 1
%  elseif  carPosition1(i, 2) == c1
%      carPosition(7, i) = 1
%  end
% end