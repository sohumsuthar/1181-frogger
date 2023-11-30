function keyPressCallback(event)
global points;
global frogPos;
global topL;
global scn;
global bottomL;
global blankL
global f;
global bushPos;
global lives;
global enemies;

enemy = (ismember(topL(frogPos(1), frogPos(2)), enemies)) || ((frogPos(1) >= 2 && frogPos(1) <= 5) && topL(frogPos(1), frogPos(2)) == 1);

% Set up, down, right and left arrow keys to the corresponding movement of the frog
% Refresh scene and/or frog position after each iteration
k = event.Key;
switch (k)
    case 'uparrow'
        if (frogPos(1) ~= 1) && ~((ismember(frogPos(2), bushPos) && frogPos(1) == 2))
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(1) = frogPos(1) - 1;
            blankL(frogPos(1), frogPos(2)) = 2;
xCheck();
            gameEndCheck();
            refreshScene();
        end
    case 'downarrow'
        if (frogPos(1) ~= 11)
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(1) = frogPos(1) + 1;
            blankL(frogPos(1), frogPos(2)) = 2;
xCheck();
            refreshScene();
        end
    case 'rightarrow'
        if (frogPos(2) ~= 11)

            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(2) = frogPos(2) + 1;
            blankL(frogPos(1), frogPos(2)) = 2;
xCheck();
            refreshScene();
        end
    case 'leftarrow'
        if (frogPos(2) ~= 1)
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(2) = frogPos(2) - 1;
            blankL(frogPos(1), frogPos(2)) = 2;
xCheck();
            refreshScene();
        end
    case 'l'
        lives = lives + 1;
end
end

% global scn;
% global bgColor
% global topL;
% global frogPos;
% global bottomL;
% global blankL;
% global X;
% global Y;
% global Z;
% global points;
% global f;
% global lives;
% global movementRows;
% global shiftAmount;
% global enemies;
% global defaultBlank;
% global bushPos;
% global difficulty;
% global speed;
% global level;
% global multiplier;