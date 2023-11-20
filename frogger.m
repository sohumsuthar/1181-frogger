clc                     % Clear the command window
clear                   % Clear workspace variables
close all               % Close all open figures

% Set up initial variables and game environment

global scn;
global topL;
global frogPos;
global bottomL;
global blankL;
global points;
global f;
global lives;
global movementRows;
global shiftAmount;
global enemies;
global defaultBlank;
global bushPos;

bgColor = [0, 0, 0];    % Background color for the game
scn = simpleGameEngine('frogger.png', 16, 16, 5, bgColor); % Create game engine

f = figure('KeyPressFcn', @(handle, event) keyPressCallback(event));
set(f, 'Position', [10, 10, 10, 10]);


frogPos = [11, 6];      % Initial position of the frog
points = 4;             % Initialize points
lives = 5;

bushPos = 1:2:11;

enemies = [15, 16, 17, 7, 5, 6];

alligatorSymbols = [15, 16, 17; 11, 15, 16; 11, 11, 15; 17, 11, 11; 16, 17, 11]; % Symbols for alligators
alligators = [2, 4; 3, 6; 4, 3; 5, 7]; % Initial positions of alligators
logs = [2, 4; 3, 6; 4, 3; 5, 7]; % Initial positions of logs
logMoveCounter = 0;     % Counter for log movement
logMoveFrequency = 1;   % Frequency of log movement
alligatorMoveCounter = 0;   % Counter for alligator movement
alligatorMoveFrequency = 1; % Frequency of alligator movement

movementRows = [2:5, 7:9];
shiftAmount = 1;

bottomL = [18, 19, 18, 19, 18, 19, 18, 19, 18, 19, 18; ... % Botton layer init
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
topL = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ... % Top layer init
    22, 24, 1, 22, 24, 1, 11, 11, 11, 1, 1; ...
    1, 22, 23, 23, 24, 1, 1, 22, 23, 24, 1; ...
    1, 1, 11, 11, 11, 1, 1, 1, 11, 11, 11; ...
    1, 1, 22, 23, 24, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 6, 1, 1, 1, 1, 7, 7, 1, 1, 1; ...
    1, 1, 1, 5, 1, 1, 1, 1, 1, 5, 1; ...
    7, 1, 1, 6, 1, 1, 1, 1, 7, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
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
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
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
    1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1];

refreshScene();
xlabel(sprintf('points: %d', points));
title('Frogger')
blankL(frogPos(1), frogPos(2)) = 2;


while true
    movementSpriteControl();
    refreshScene();
    pause(1);
end


