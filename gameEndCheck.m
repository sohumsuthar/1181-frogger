function gameEndCheck()
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

if ((frogPos(2) == 2 || frogPos(2) == 4 || frogPos(2) == 6 || frogPos(2) == 8 || frogPos(2) == 10) && frogPos(1) == 1)
    oldPos = frogPos(2);
    frogPos = [11, 6];
    topL(1, oldPos) = 14; % Place a marker on the log
    resetFrogPos(false);
    refreshScene();
elseif points == 5
    % xlabel(sprintf('GAME OVER!!! points: %d', points)); % Display points in the plot
    drawScene(scn, bottomL, topL, blankL);
    figure(f);
end
end