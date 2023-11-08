clc
clear
close all

bgColor = [0, 0, 0];
scn = simpleGameEngine('frogger.png', 16, 16, 5, bgColor);
frogPos = [11, 6];
alligatorSymbols = [15, 16, 17];
alligators = [2, 1; 3, 1; 4, 1; 5, 1];
alligatorMoveCounter = 0; 
alligatorMoveFrequency = 1;

bottomL = [18, 19, 18, 19, 18, 19, 18, 19, 18, 19, 18; ...
    21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, ; ...
    21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, ; ...
    21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, ; ...
    21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, ; ...
    20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
topL = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

topL(frogPos(1), frogPos(2)) = 2;
while true
    alligatorMoveCounter = alligatorMoveCounter + 1;

    if alligatorMoveCounter == alligatorMoveFrequency
        alligatorMoveCounter = 0;

        for i = 1:size(alligators, 1)
            
            topL(alligators(i, 1), alligators(i, 2):alligators(i, 2) + 2) = 1;

            alligators(i, 2) = alligators(i, 2) + 1;
               
            topL(alligators(i, 1), alligators(i, 2):alligators(i, 2) + 2) = alligatorSymbols;
        end
    end
    for i = 1:size(alligators, 1)
        topL(alligators(i, 1), alligators(i, 2):alligators(i, 2) + 2) = alligatorSymbols;
    end

    for i = 1:size(alligators, 1)
        if frogPos(1) == alligators(i, 1) && any(frogPos(2) >= alligators(i, 2) & frogPos(2) <= alligators(i, 2) + 2)

            topL(frogPos(1), frogPos(2)) = 1;
            frogPos = [11, 6];
            topL(frogPos(1), frogPos(2)) = 2;
        end
    end
    drawScene(scn, bottomL, topL);
    k = getKeyboardInput(scn);
    if strcmp(k, 'uparrow') && (frogPos(1) ~= 1)
        topL(frogPos(1), frogPos(2)) = 1;
        frogPos(1) = frogPos(1) - 1;
        topL(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'downarrow') && (frogPos(1) ~= 11)
        topL(frogPos(1), frogPos(2)) = 1;
        frogPos(1) = frogPos(1) + 1;
        topL(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'rightarrow') && (frogPos(2) ~= 11)
        topL(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) + 1;
        topL(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'leftarrow') && (frogPos(2) ~= 1)
        topL(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) - 1;
        topL(frogPos(1), frogPos(2)) = 2;
    end
   pause(0.05);
end





