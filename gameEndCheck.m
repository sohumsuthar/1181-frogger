% function to check whether the game ended or not, also changing the level
% when needed
function gameEndCheck()
% call global variables as needed
global frogPos;
global topL;
global lives;
global movementRows;
global speed;
global level;
global multiplier;
global homes;

% read audio for when the frog reaches home
[y, Fs] = audioread('sound-frogger-extra.wav');


if ((frogPos(2) == 2 || frogPos(2) == 4 || frogPos(2) == 6 || frogPos(2) == 8 || frogPos(2) == 10)...
        && frogPos(1) == 1) && homes(frogPos(2)/2) ~= 1 % add bush when the frog position is satisfying

    oldPos = frogPos(2); % note old pos of frog

    homes(oldPos/2) = 1; % set index to true in the home array

    sound(y*2.3, Fs); % play completion song

    topL(1, oldPos) = 14; % Place a marker in the bush on the log

    resetFrogPos(false); % reset frog pos with loss set to false

    frog = 0; % set indexes for home to 0

    for i= 2:2:10 % check all homes
        if topL(1, i) == 14 % count all frogs in homes
            frog = frog + 1;
        end
    end
    if frog == 5 % if all homes are filled, go to next level 

        homes = zeros(1, 5); % clear homes array 
        level = level + 1; % inc level
        lives = lives + 1; % inc lives
        speed = (-0.2 * log((level+1)/3) + 0.8) * multiplier; % changes speed of the game

        topL(1, :) = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
        if level == 2 
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
        elseif level == 3
            movementRows(end + 1) = 6;
            topL = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
                1, 22, 24, 1, 22, 24, 1, 1, 15, 16, 17; ...
                1, 22, 23, 24, 1, 1, 1, 22, 23, 24, 1; ...
                1, 11, 11, 1, 1, 15, 16, 17, 1, 11, 11; ...
                1, 1, 22, 23, 24, 1, 1, 22, 24, 1, 1; ...
                1, 1, 1, 1, 53, 54, 1, 1, 1, 1, 1; ...
                1, 6, 1, 34, 35, 1, 7, 7, 1, 1, 1; ...
                1, 1, 1, 5, 1, 1, 1, 1, 1, 5, 1; ...
                7, 1, 1, 6, 1, 34, 35, 1, 7, 1, 1; ...
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1;...
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

        elseif level == 4
            topL = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
                1, 22, 24, 1, 22, 24, 1, 1, 15, 16, 17; ...
                1, 22, 23, 24, 1, 1, 1, 22, 23, 24, 1; ...
                1, 11, 11, 56, 1, 15, 16, 17, 1, 11, 11; ...
                1, 1, 22, 23, 24, 1, 1, 22, 24, 1, 1; ...
                1, 1, 1, 1, 53, 54, 1, 1, 1, 53, 54; ...
                1, 6, 1, 34, 35, 1, 7, 7, 1, 1, 1; ...
                1, 1, 1, 5, 1, 1, 1, 1, 1, 5, 1; ...
                7, 1, 1, 6, 1, 34, 35, 1, 7, 1, 1; ...
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1;...
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
       elseif level == 5
            topL = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
                1, 22, 24, 1, 22, 24, 1, 1, 15, 16, 17; ...
                1, 22, 23, 24, 1, 1, 1, 22, 23, 24, 1; ...
                1, 11, 11, 56, 1, 15, 16, 17, 1, 11, 11; ...
                1, 1, 22, 23, 24, 1, 1, 22, 24, 1, 1; ...
                1, 1, 1, 1, 53, 54, 1, 1, 1, 53, 54; ...
                1, 6, 1, 34, 35, 1, 7, 7, 1, 1, 1; ...
                1, 1, 1, 5, 1, 1, 1, 1, 1, 5, 1; ...
                7, 1, 1, 6, 1, 34, 35, 1, 7, 1, 1; ...
                1, 1, 1, 1, 53, 54, 1, 1, 1, 1, 1; ...
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1;...
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
        end
    end
end
refreshScene();
end