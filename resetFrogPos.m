function resetFrogPos()
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

frogPos = [11, 6]; % Reset frog position
blankL(frogPos(1), frogPos(2)) = 2; % Update frog position
lives = lives - 1;
blankL = defaultBlank;
refreshScene();
end