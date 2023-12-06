% clear everything
clc
clear
close all
clear sound
clear player

% global initializations
global speed; % pause speed
global gameOver; % bool for game over state
global Timer; % timer for trophy
global player; % player for song

initVars(); % initialize the game
startScreen(); % display the start screen


% Add a pause to refresh scene and sprite movement
while true
    tic; % start the timer for the trophy
    play(player); % play the background music
    while ~gameOver % in the current game session
        movementSpriteControl(); % move the sprites that need to be moved
        refreshScene(); % refresh the scene and publish the scene to the fgr
        pause(speed); % wait
    end

    Timer = toc; % set timer
    restartGame(); % reset vars for new game
end


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



function initVars()
global scn;
global bgColor
global topL;
global frogPos;
global bottomL;
global blankL;
global X;
global Y;
global Z;
global points;
global f;
global lives;
global movementRows;
global shiftAmount;
global enemies;
global defaultBlank;
global bushPos;
global difficulty;
global speed;
global level;
global multiplier;
global gameOver;
global homes;
global player;


% Set background color for the game and create the game engine
bgColor = [0, 0, 0];
scn = simpleGameEngine('frogger.png', 16, 16, 5, bgColor);

f = figure('KeyPressFcn', @(handle, event) keyPressCallback(event));
set(f, 'Position', [10, 10, 10, 10]);

% Set the initial position of the frog, starting amount of points to zero,
% initial speed to 1, and difficuty to zero
frogPos = [11, 6];
points = 0;
lives = 5;
gameOver = false;
homes = zeros(1, 5);

difficulty = 0;
level = 1;
multiplier = 0.6;
speed = (-0.2 * log((level+1)/3) + 0.8) * multiplier;



bushPos = 1:2:11;

enemies = [17, 7, 5, 6, 34, 35, 53, 56];



movementRows = [2:5, 7:9];
shiftAmount = 1;

% Insert start menu
X = ones(12, 11);
Y = ones(12, 11);
Z = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 36, 37, 38, 39, 39, 40, 37, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 5, 1, 14, 1, 11, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, letterIndex('s'), letterIndex('t'), letterIndex('a'),...
    letterIndex('r'), letterIndex('t'), 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

% Set the initial layout of the bottom, top, blank, and defult blank layers
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
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
topL = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    22, 24, 1, 22, 24, 1, 11, 11, 11, 1, 1; ...
    1, 22, 23, 23, 24, 1, 1, 22, 23, 24, 1; ...
    1, 1, 11, 11, 11, 1, 1, 1, 11, 11, 11; ...
    1, 1, 22, 23, 24, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 6, 1, 1, 1, 1, 7, 7, 1, 1, 1; ...
    1, 1, 1, 5, 1, 1, 1, 1, 1, 5, 1; ...
    7, 1, 1, 6, 1, 1, 1, 1, 7, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1;...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
blankL = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1 1, 1, 1, 1, 1;...
    32, 45, 1, 1, 1, 1, 1, 1, 1, 33, 40];
defaultBlank = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
fprintf(['Hello!, this is Frogger. The objective is to fill in all the homes across ' ...
    'the river without falling in the water, \n' ...
    'getting eaten by a croc, getting run over, and dying to an otter!\n' ...
    'Once you fill all the spots, the game will progressivley get harder and faster,\n' ...
    'granting you a life for filling the homes.\n' ...
    'Good luck and have fun! \n \n'])
[y, Fs] = audioread('kensample.mp3');
volume = 0.3;
player = audioplayer(volume .* y, Fs);

end
function keyPressCallback(event)
global frogPos;
global blankL
global bushPos;
global lives;
global homes;

% Set up, down, right and left arrow keys to the corresponding movement of the frog
% Refresh scene and/or frog position after each iteration
k = event.Key;

% [y, Fs] = audioread('sound-frogger-hop.wav');
% Fs = Fs *2;
% sound(y, Fs);
switch (k)
    case {'uparrow', 'w'}
        if (frogPos(1) ~= 1) && ~((ismember(frogPos(2), bushPos) && frogPos(1) == 2)) && ~(frogPos(1) == 2 && homes(frogPos(2)/2) == 1)
            %sound(y, Fs);
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(1) = frogPos(1) - 1;
            blankL(frogPos(1), frogPos(2)) = 2;
            xCheck(); % Check to see if frog is touching an enemy and if so resets the frog's position
            gameEndCheck(); % Checks to see if you've advanced a level or lost a life
            refreshScene(); % Updates scores, lives, level, and draws all leyers
        end
    case {'downarrow', 's'}
        if (frogPos(1) ~= 11)
            %sound(y, Fs);
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(1) = frogPos(1) + 1;
            blankL(frogPos(1), frogPos(2)) = 2;
            xCheck();
            refreshScene();
        end
    case {'rightarrow', 'd'}
        if (frogPos(2) ~= 11)
            %sound(y, Fs);
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(2) = frogPos(2) + 1;
            blankL(frogPos(1), frogPos(2)) = 2;
            xCheck();
            refreshScene();
        end
    case {'leftarrow', 'a'}
        if (frogPos(2) ~= 1)
            %sound(y, Fs);
            blankL(frogPos(1), frogPos(2)) = 1;
            frogPos(2) = frogPos(2) - 1;
            blankL(frogPos(1), frogPos(2)) = 2;
            xCheck();
            refreshScene();
        end
    case 'l'
        lives = lives + 1; % Add lives if you press l on keyboard
end
end

function letter = letterIndex(value)
% Insert start menu letters
if strcmp(value, 's')
    letter = 51;
elseif strcmp(value, 't')
    letter = 52;
elseif strcmp(value, 'g')
    letter = 25;
elseif strcmp(value, 'a')
    letter = 26;
elseif strcmp(value, 'm')
    letter = 27;
elseif strcmp(value, 'e')
    letter = 28;
elseif strcmp(value, 'o')
    letter = 29;
elseif strcmp(value, 'v')
    letter = 30;
elseif strcmp(value, 'r')
    letter = 31;
end
end

function movementSpriteControl()
global frogPos;
global topL;
global bottomL;
global blankL
global movementRows;
global shiftAmount;
global enemies;

% Circularily shift the positions of the sprites unless it has reached one
% side of the sceen and if so, restart its position at the other end of the screen
% Refresh scene and/ or frog position after each iteration
for i = movementRows
    if mod(i, 2) == 1 || i == 6

        if frogPos(1) == i && (~ismember(topL(i, frogPos(2)), enemies) && topL(i, frogPos(2)) ~= 1)

            frogPos(2) = frogPos(2) - shiftAmount;
            if frogPos(2) == 0
                resetFrogPos(true);
            else
                blankL(i, :) = circshift(blankL(i, :), [0, -shiftAmount]);
                refreshScene();
            end
        elseif frogPos(1) == i && (ismember(topL(i, frogPos(2)), enemies) ||  bottomL(i, frogPos(2)) == 21)
            resetFrogPos(true);
        end
        topL(i, :) = circshift(topL(i, :), [0, -shiftAmount]);
    else

        if frogPos(1) == i && (~ismember(topL(i, frogPos(2)), enemies) && topL(i, frogPos(2)) ~= 1)

            frogPos(2) = frogPos(2) + shiftAmount;
            if frogPos(2) == 12
                resetFrogPos(true);
            else
                blankL(i, :) = circshift(blankL(i, :), [0, shiftAmount]);
                refreshScene();
            end
        elseif frogPos(1) == i && (ismember(topL(i, frogPos(2)), enemies) ||  bottomL(i, frogPos(2)) == 21)
            resetFrogPos(true);

        end
        topL(i, :) = circshift(topL(i, :), [0, shiftAmount]);
    end

end
xCheck();
refreshScene();
end


% Input number from sprite sheet for score and number of lives

function result = numPref(value)
    if value == 0
        result = 41;
    elseif value == 9
        result = 50;
    else
        result = str2double(['4', num2str(value +1)]);
    end
end
% Returns ones digit of inputted value
function one = onesDigit(value)
one = mod(value, 10);
end

function refreshScene()
global points;
global topL;
global scn;
global bottomL;
global blankL
global f;
global lives;
global speed;
global level;
global gameOver;
global player;

% If the frog's lives become zero, refresh scene with GAME OVER sprites on
% the blank layer
if ~isplaying(player)
    play(player);
end

if lives == 0
    blankL(6, :) = [1, 25, 26, 27, 28, 1, 29, 30, 28, 31, 1];
    blankL(9, :) = [1, 1, 1, letterIndex('s'), letterIndex('t'), letterIndex('a'),...
        letterIndex('r'), letterIndex('t'), 1, 1, 1];
    topL(6, 6) = 1;
    bottomL(6, 6) = 1;
    speed = 0.1;
    gameOver = true;

end

onesDigitP = onesDigit(points);
tensDigitP = tensDigit(points);
onesDigitL = onesDigit(level);
tensDigitL = tensDigit(level);
blankL(12,:) = [33, numPref(tensDigit(points)), numPref(onesDigit(points)), 1, 55, numPref(tensDigit(level)), numPref(onesDigit(level)), 1, 32, numPref(tensDigit(lives)), numPref(onesDigit(lives))];

% Draw scene with new blank layer that shows GAME OVER
drawScene(scn, bottomL, topL, blankL);

figure(f);
end

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


function restartGame()
global gameOver;
global scn;
global points
global Timer;


fprintf('')
fileID = fopen('score_trophy.txt', 'w');
fprintf(fileID, 'Score: %d\n Time: %.2f\n', points, Timer);
fclose(fileID);

disp('Score saved to score_trophy.txt');

pause(1);
getMouseInput(scn);
close all;
gameOver = false;
initVars();
resetFrogPos(false);
points = 0;
end


function startScreen()
global scn;
global X;
global Y;
global Z;
global blankL;
global frogPos;

% Draw start menu scene
drawScene(scn, X, Y, Z);
getMouseInput(scn);
% Scene labels and titles
refreshScene();
blankL(frogPos(1), frogPos(2)) = 2;
end


% Returns the tens digit of the inputed value
function tens = tensDigit(value)
tens = floor(mod(value, 100) / 10);
end


% function to check whether the frog dies or not
function xCheck()

% bring global variables to workspace
global topL;
global frogPos;
global enemies;

% read audio files for frog death sounds
[y1, Fs1] = audioread('sound-frogger-squash.wav');
[y2, Fs2] = audioread('sound-frogger-plunk.wav');

% Reset the frog's position if it gets hit by an enemy
if (ismember(topL(frogPos(1), frogPos(2)), enemies)) % if the frog position in the top layer is an enemy sprite:
    sound(y1, Fs1); % play death sound
    resetFrogPos(true); % loss is true
elseif ((frogPos(1) >= 2 && frogPos(1) <= 5) && topL(frogPos(1), frogPos(2)) == 1) % if the frog is in the water
    sound(y2, Fs2) % play death sound for water
    resetFrogPos(true); 
end
end