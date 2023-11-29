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
global bushPos;
global difficulty;
global speed;

% Check whether the frogger is in both the first row and one of the
% positions in the bushes

if ((frogPos(2) == 2 || frogPos(2) == 4 || frogPos(2) == 6 || frogPos(2) == 8 || frogPos(2) == 10) && frogPos(1) == 1)
    oldPos = frogPos(2);
    topL(1, oldPos) = 14; % Place a marker in the bush on the log
    resetFrogPos(false);
    frog = 0;
    for i= 2:2:10
        if topL(1, i) == 14
            frog = frog +1;
        end
    end
    if frog == 5
        level = level + 1;
        topL(1, :) = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
        speed = speed - 0.1;
        topL = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
            22, 23, 24, 1, 22, 24, 1, 1, 15, 16, 17; ...
            1, 22, 23, 23, 24, 1, 1, 22, 23, 24, 1; ...
            1, 11, 11, 1, 1, 15, 16, 17, 1, 11, 1; ...
            1, 1, 22, 23, 24, 1, 1, 22, 24, 1, 1; ...
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
            1, 6, 1, 34, 35, 1, 7, 7, 1, 1, 1; ...
            1, 1, 1, 5, 1, 1, 1, 1, 1, 5, 1; ...
            7, 1, 1, 6, 1, 34, 35, 1, 7, 1, 1; ...
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1;...
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
    end
    refreshScene();
end