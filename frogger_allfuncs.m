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



% function to initialize the variables at the begininng of the game

function initVars()

% scene variable for the simpleGameEngine
global scn; 

% array to hold background color
global bgColor 

% matrix to hold the top layer
global topL; 

% vector to hold current frog position
global frogPos; 

% matrix to hold bottom layer
global bottomL;

% matrix to hold blank layer for the frog to traverse
global blankL;

% matrix to hold empty space for menu start screen
global X;

% matrix to hold empty space for menu start screen
global Y;

% matrix to hold start menu screen
global Z;

% scalar to hold points accrued by the user
global points;

% variable to hold small figure that will capture keystrokes
global f;

% scalar value that will hold the number of lives the user has
global lives;

% matrix that holds the rows in the game that shift
global movementRows;

% matrix that holds the amount to shift for the sprites that move
global shiftAmount;

% matrix that holds the sprite indexes of all enemy sprites
global enemies;

% matrix that holds a default blank template for the layer that contains
% the frog
global defaultBlank;

% array that holds all the positions of the frogs
global bushPos;

% scalar value that holds difficulty value
global difficulty;

% scalar value that holds the pause time between frames
global speed;

% scalar value that holds the current level the player is at
global level;

% multiplier for the logarithmic speed change
global multiplier;

% boolean state for whether the game is over or not
global gameOver;

% array to hold how many homes are filled with logical zeros and ones
global homes;

% variable to hold audioplayer for background music
global player;


% Set background color for the game and create the game engine
bgColor = [0, 0, 0];
% set the simpleGameEngine scene
scn = simpleGameEngine('frogger.png', 16, 16, 5, bgColor);

% figure that stays on top to record keystrokes
f = figure('KeyPressFcn', @(handle, event) keyPressCallback(event));
% make the figure small and insignificant
set(f, 'Position', [10, 10, 10, 10]);

% Set the initial position of the frog, starting amount of points to zero,
frogPos = [11, 6];

% set points to 0
points = 0;

% set lives to 5
lives = 5;

% set game over state to false
gameOver = false;

% initialize the homes array to all zeros indicating that none of them have
% been filled
homes = zeros(1, 5);

% set difficulty to 0
difficulty = 0;

% set level to 1
level = 1;

% set multiplier to 0.6
multiplier = 0.6;

% set speed to a log function that increases and converges
speed = (-0.2 * log((level+1)/3) + 0.8) * multiplier;

% create array to hold bush positions
bushPos = 1:2:11;

% initialize enemies to all enemy sprites
enemies = [17, 7, 5, 6, 34, 35, 53, 56];

% use this line to debug to pass levels quickly
% enemies = [0];

% set the movement rows to the river and road
movementRows = [2:5, 7:9];

shiftAmount = 1;

% Insert start menu
X = ones(12, 11); % Creates a 12x11 matric with all ones
Y = ones(12, 11); % Creates a 12x11 matric with all ones
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
% Inserts all start menu sprites such as the game title, character sprites,
% and START

% Set the initial layout of the bottom, top, blank, and defult blank layers

% Initialize bottom layer with the water, homes, and bushes
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

% Initialize top layer with the logs and cars
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

% Initialize blank layer with the points and lives symbol
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

% Initialize the default blank layer with the frog's starting position
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


% Print game instrutions in command window when the game starts
fprintf(['Hello!, this is Frogger. The objective is to fill in all the homes across ' ...
    'the river without falling in the water, \n' ...
    'getting eaten by a croc, getting run over, and dying to an otter!\n' ...
    'Once you fill all the spots, the game will progressivley get harder and faster,\n' ...
    'granting you a life for filling the homes.\n' ...
    'Good luck and have fun! \n \n'])

% Plays audio when game starts
[y, Fs] = audioread('kensample.mp3'); 
volume = 0.3;
player = audioplayer(volume .* y, Fs);

end



% function to control the movement of the sprites that traverse the road
% and river

function movementSpriteControl()

% see function 'initVars' for all variable informations
% global variable initializations
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

for i = movementRows % for each row that moves

    if mod(i, 2) == 1 || i == 6 % if its an odd row or if its the row containing the snake,

        % if the frog is on the row and is not touching an enemy or the
        % water:
        if frogPos(1) == i && (~ismember(topL(i, frogPos(2)), enemies) && topL(i, frogPos(2)) ~= 1)

            frogPos(2) = frogPos(2) - shiftAmount; % shift the frog position

            if frogPos(2) == 0 % if the frog is in an illegal position, 
                % decrement lives and reset its position

                resetFrogPos(true);

            else
                % else: print updated result to layer given that the frog
                blankL(i, :) = circshift(blankL(i, :), [0, -shiftAmount]);
                refreshScene(); % refresh the scene 
            end

        elseif frogPos(1) == i && (ismember(topL(i, frogPos(2)), enemies) ...
                ||  bottomL(i, frogPos(2)) == 21) % if the frog is touching an enemy
            resetFrogPos(true); % reset frog position and decrement lives by one
        end

        % finally, shift the entire top layer
        topL(i, :) = circshift(topL(i, :), [0, -shiftAmount]); 


    else % repeat all above steps if the row is an even row

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

xCheck(); % check for frog death

refreshScene(); % refresh the scene
end



% function to check whether the game ended or not, also changing the level
% when needed

function gameEndCheck()

% see function 'initVars' for all variable informations
% global variable initializations
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

        topL(1, :) = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; % reset all the homes
        if level == 2 % change layer for level 2 difficulty
            
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
        elseif level == 3 % change layer for level 3 difficulty

            movementRows(end + 1) = 6; % add a row to shift for the snake
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

        elseif level == 4 % change layer for level 4 difficulty

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

       elseif level == 5 % change layer for level 5 difficulty

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

refreshScene(); % reset the game board

end



% A function that calls a key press whenever the up/W, down/S, left/A, or
% right/D keys are pressed
function keyPressCallback(event)

% see function 'initVars' for all variable information

global frogPos;
global blankL
global bushPos;
global lives;
global homes;

% Set up, down, right and left arrow keys to the corresponding movement of the frog
k = event.Key;

% [y, Fs] = audioread('sound-frogger-hop.wav');
% Fs = Fs *2;
% sound(y, Fs);

switch (k)
    case {'uparrow', 'w'}
        if (frogPos(1) ~= 1) && ~((ismember(frogPos(2), bushPos) && frogPos(1) == 2))...
                && ~(frogPos(1) == 2 && homes(frogPos(2)/2) == 1) % If the frog is not going to run into a bush, move up
            %sound(y, Fs);
            blankL(frogPos(1), frogPos(2)) = 1; % Clears frog's postion
            frogPos(1) = frogPos(1) - 1; % Deletes previous row
            blankL(frogPos(1), frogPos(2)) = 2; % Creates new blank layer
            xCheck(); % Check to see if frog is touching an enemy and if so resets the frog's position
            gameEndCheck(); % Checks to see if you've advanced a level or lost a life
            refreshScene(); % Updates scores, lives, level, and draws all leyers
        end

    case {'downarrow', 's'}
        if (frogPos(1) ~= 11) % If frog's position is not at row 11, then move down
            %sound(y, Fs);
            blankL(frogPos(1), frogPos(2)) = 1; % Clears frog's postion
            frogPos(1) = frogPos(1) + 1; % Adds a row below
            blankL(frogPos(1), frogPos(2)) = 2; % Creates new blank layer
            xCheck(); % Checks to see if you've advanced a level or lost a life
            refreshScene(); % Updates scores, lives, level, and draws all leyers
        end

    case {'rightarrow', 'd'}
        if (frogPos(2) ~= 11) % If frog's position is not at collumn 11, then move right
            %sound(y, Fs);
            blankL(frogPos(1), frogPos(2)) = 1; % Clears frog's postion
            frogPos(2) = frogPos(2) + 1; % Adds a collumn to the left
            blankL(frogPos(1), frogPos(2)) = 2; % Creates new blank layer
            xCheck(); % Checks to see if you've advanced a level or lost a life
            refreshScene(); % Updates scores, lives, level, and draws all leyers
        end

    case {'leftarrow', 'a'}
        if (frogPos(2) ~= 1) % If frog's position is not at collumn 1, then move left
            %sound(y, Fs);
            blankL(frogPos(1), frogPos(2)) = 1; % Clears frog's postion
            frogPos(2) = frogPos(2) - 1; % Deletes previous collumn
            blankL(frogPos(1), frogPos(2)) = 2; % Creates new blank layer
            xCheck(); % Checks to see if you've advanced a level or lost a life
            refreshScene(); % Updates scores, lives, level, and draws all leyers
        end

    case 'l'
        lives = lives + 1; % Add lives if you press l on keyboard
end
end



% function to check whether the frog dies or not
function xCheck()

% see function 'initVars' for all variable informations
% global variable initializations
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


% Returns the tens digit of the inputed value
function tens = tensDigit(value)

tens = floor(mod(value, 100) / 10);

end

% Returns ones digit of inputted value
function one = onesDigit(value)

one = mod(value, 10);

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


% Function that creates letter sprites necessary for start menu screen to
% say START and GAME OVER at the end of the game
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


% Draws scene with the start menu components such as the game title,
% character sprites, and the mouse input to allow the user to press START
function startScreen()

% see function 'initVars' for all variable informations
% global variable initializations

global scn;
global X;
global Y;
global Z;
global blankL;
global frogPos;

% Draw start menu scene and initialize mouse input
drawScene(scn, X, Y, Z);
getMouseInput(scn);

% refresh scene with new blank layer
refreshScene();
blankL(frogPos(1), frogPos(2)) = 2;

end

% a function to handle the game restarting after the game has ended

function restartGame()

% see function 'initVars' for all variable informations
% global variable initializations

global gameOver;
global scn;
global points
global Timer;



fileID = fopen('score_trophy.txt', 'w'); % access or create a file named score_trophy.txt to contain 
% the final score and time receieved by the user before the game ended
fprintf(fileID, 'Score: %d\n Time: %.2f\n', points, Timer); % write points and time to the file
fclose(fileID); % close the file

fprintf('Score saved to score_trophy.txt'); % show that the final score and time has been saved

pause(1); % pause for a second to avoid lag

getMouseInput(scn); % wait for mouse input for progress on the game over screen

close all; % close all figures

gameOver = false; % reset the boolean state of the gameOver variable
initVars(); % re-initialize the variables for the next game 
resetFrogPos(false); % reset the frog position
points = 0; % initialize the points to 0

end


% function tp reset the frog position and handle losses

function resetFrogPos(loss) % boolean for whether the player lost a life or not

% see function 'initVars' for all variable informations
% global variable initializations
global points;
global frogPos;
global blankL
global lives;
global defaultBlank;

% Reset the frog position after dying or completing the level
frogPos = [11, 6];

% Update frog position, number of lives, and/or amount of points
% Refresh scene at the end of each iteration

blankL(frogPos(1), frogPos(2)) = 2; % print frog at default position

if loss % if loss
    if lives ~= 0
        % decrement lives if lives are not 0
        lives = lives - 1;
    end

else
    % if not, increment the points
    points = points + 1;
end

blankL = defaultBlank; % reset the blank layer

refreshScene(); % refresh the scene

end

% Function that updates the players lives and points when refreshing the
% scene or refreshes the scene to GAME OVER layer if the lives are zero
function refreshScene()

% see function 'initVars' for all variable information
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

% If the frog's lives become zero, refresh scene with GAME OVER and START sprites on
% the blank layer
if ~isplaying(player)
    play(player);
end

% If the frog's lives are zero refresh scene with new blank layer
% containing GAME OVER in row 6 and START in row 9 
if lives == 0
    blankL(6, :) = [1, 25, 26, 27, 28, 1, 29, 30, 28, 31, 1];
    blankL(9, :) = [1, 1, 1, letterIndex('s'), letterIndex('t'), letterIndex('a'),...
        letterIndex('r'), letterIndex('t'), 1, 1, 1];
    topL(6, 6) = 1;
    bottomL(6, 6) = 1;
    speed = 0.1;
    gameOver = true;

end

% Prints the points, lives, and levels
blankL(12,:) = [33, numPref(tensDigit(points)), numPref(onesDigit(points)), 1, 55, numPref(tensDigit(level)), numPref(onesDigit(level)), 1, 32, numPref(tensDigit(lives)), numPref(onesDigit(lives))];

% Draw scene with new blank layer
drawScene(scn, bottomL, topL, blankL);

% Ensures that the figure is constantly in focus
figure(f);
end



