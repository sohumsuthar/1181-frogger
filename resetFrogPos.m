function resetFrogPos(loss)
global points;
global frogPos;
global topL;
global scn;
global bottomL;
global blankL
global f;
global lives;
global movementRows;
global shiftAmount;
global enemies;
global defaultBlank;

% Reset the frog position after dying or completing the level
frogPos = [11, 6];

% Update frog position, number of lives, and/or amount of points
% Refresh scene at the end of each iteration
blankL(frogPos(1), frogPos(2)) = 2;
if loss
    if lives ~= 0
 
        lives = lives - 1;
    end
    else
    points = points + 1;
end
blankL = defaultBlank;
refreshScene();
end