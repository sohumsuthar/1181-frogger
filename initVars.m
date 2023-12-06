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