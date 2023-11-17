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

bgColor = [0, 0, 0];    % Background color for the game
scn = simpleGameEngine('frogger.png', 16, 16, 5, bgColor); % Create game engine

f = figure('KeyPressFcn', @(handle, event) keyPressCallback(event));
set(f, 'Position', [10, 10, 10, 10]); % Adjust the position as needed


frogPos = [11, 6];      % Initial position of the frog
points = 0;             % Initialize points
lives = 5;

enemies = [15, 16, 17, 5, 6];

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

drawScene(scn, bottomL, topL, blankL);
xlabel(sprintf('points: %d', points)); % Display points in the plot
title('Frogger') % Set the game title
blankL(frogPos(1), frogPos(2)) = 2;


% Game loop - runs the game continuously
while true
    % alligatorMoveCounter = alligatorMoveCounter + 1; % Increment the alligator movement counter
    %
    % % Move alligators at the specified frequency
    % if alligatorMoveCounter == alligatorMoveFrequency
    %     alligatorMoveCounter = 0; % Reset the counter
    %
    %     % Update positions of alligators on the grid
    %     for i = 1:size(alligators, 1)
    %         % Clear the previous alligator positions
    %         topL(alligators(i, 1), alligators(i, 2):alligators(i, 2) + 2) = 1;
    %         % Move the alligator one step to the right
    %         if alligators(i, 2) == 9
    %             alligators(i, 2) = 1;
    %
    %             topL(alligators(i, 1), alligators(i, 2):alligators(i, 2) + 2) = alligatorSymbols();
    %         else
    %             alligators(i, 2) = alligators(i, 2) + 1;
    %         end
    %         % Display the alligator in its new position
    %
    %     end
    % end


    % Specify the rows to be shifted


    % Rightward shift for the specified rows
    for i = movementRows
        if mod(i, 2) == 1
            topL(i, :) = circshift(topL(i, :), [0, -shiftAmount]);
            if frogPos(1) == i && (~ismember(topL(i, frogPos(2)), enemies) && topL(i, frogPos(2)) ~= 1)

                frogPos(2) = frogPos(2) - shiftAmount;
                if frogPos(2) == 0
                    frogPos = [11, 6]; % Reset frog position
                    blankL(frogPos(1), frogPos(2)) = 2; % Update frog position
                    lives = lives - 1;
                    blankL = defaultBlank;
                else
                    blankL(i, :) = circshift(blankL(i, :), [0, -shiftAmount]);
                end
            end
        else
            topL(i, :) = circshift(topL(i, :), [0, shiftAmount]);
            if frogPos(1) == i && (~ismember(topL(i, frogPos(2)), enemies) && topL(i, frogPos(2)) ~= 1)

                frogPos(2) = frogPos(2) + shiftAmount;
                if frogPos(2) == 12
                    frogPos = [11, 6]; % Reset frog position
                    blankL(frogPos(1), frogPos(2)) = 2; % Update frog position
                    lives = lives - 1;
                    blankL = defaultBlank;
                else
                    blankL(i, :) = circshift(blankL(i, :), [0, shiftAmount]);
                end
            end
        end

    end
    drawScene(scn, bottomL, topL, blankL);
    xlabel(sprintf('points: %d', points)); % Display points in the plot
    title('Frogger') % Set the game title
    figure(f);
    % % Check if the frog collides with an alligator
    % for i = 1:size(alligators, 1)
    %     if frogPos(1) == alligators(i, 1) && any(frogPos(2) >= alligators(i, 2) && frogPos(2) <= alligators(i, 2) + 2)
    %         % Reset frog position and update grid
    %         blankL(frogPos(1), frogPos(2)) = 1;
    %         frogPos = [11, 6];
    %         blankL(frogPos(1), frogPos(2)) = 2;
    %     end
    % end


    % Draw the game scene
    drawScene(scn, bottomL, topL, blankL);
    xlabel(sprintf('points: %d', points)); % Display points in the plot
    title('Frogger') % Set the game title
    figure(f);


    % Update frog position and points based on movement and reaching the top
    if ((frogPos(2) == 2 || frogPos(2) == 4 || frogPos(2) == 6 || frogPos(2) == 8 || frogPos(2) == 10) && frogPos(1) == 1)
        oldPos = frogPos(2);
        frogPos = [11, 6];
        blankL(1, oldPos) = 14; % Place a marker on the log
        points = points + 1; % Increment points
        frogPos = [11, 6]; % Reset frog position
        blankL(frogPos(1), frogPos(2)) = 2; % Update frog position
        drawScene(scn, blankL);
    elseif points == 5
        xlabel(sprintf('GAME OVER!!! points: %d', points)); % Display points in the plot
        drawScene(scn, blankL);
        figure(f);
    end


    pause(0.5); % Pause to control the game speed
end




