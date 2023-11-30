function keyPressCallback(event)
global frogPos;
global topL;
global blankL
global bushPos;
global lives;
global enemies;

% Set up, down, right and left arrow keys to the corresponding movement of the frog
% Refresh scene and/or frog position after each iteration
k = event.Key;
switch (k)
    case {'uparrow', 'w'}
        if (frogPos(1) ~= 1) && ~((ismember(frogPos(2), bushPos) && frogPos(1) == 2))
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(1) = frogPos(1) - 1;
            blankL(frogPos(1), frogPos(2)) = 2;
            xCheck();
            gameEndCheck();
            refreshScene();
        end
    case {'downarrow', 's'}
        if (frogPos(1) ~= 11)
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(1) = frogPos(1) + 1;
            blankL(frogPos(1), frogPos(2)) = 2;
            xCheck();
            refreshScene();
        end
    case {'rightarrow', 'd'}
        if (frogPos(2) ~= 11)

            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(2) = frogPos(2) + 1;
            blankL(frogPos(1), frogPos(2)) = 2;
            xCheck();
            refreshScene();
        end
    case {'leftarrow', 'a'}
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