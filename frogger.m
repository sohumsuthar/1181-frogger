clc                     % Clear the command window
clear                   % Clear workspace variables
close all               % Close all open figures

% Set up initial variables and game environment
bgColor = [0, 0, 0];    % Background color for the game
scn = simpleGameEngine('frogger.png', 16, 16, 5, bgColor); % Create game engine
frogPos = [11, 6];      % Initial position of the frog
alligatorSymbols = [15, 16, 17]; % Symbols for alligators
alligators = [2, 4; 3, 6; 4, 3; 5, 7]; % Initial positions of alligators
logs = [2, 4; 3, 6; 4, 3; 5, 7]; % Initial positions of logs
logMoveCounter = 0;     % Counter for log movement
logMoveFrequency = 1;   % Frequency of log movement
alligatorMoveCounter = 0;   % Counter for alligator movement
alligatorMoveFrequency = 1; % Frequency of alligator movement
points = 0;             % Initialize points



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
    22, 24, 1, 1, 1, 1, 1, 1, 1, 11, 11; ...
    1, 22,  23, 23, 24, 1, 1, 1, 1, 1, 1; ...
    11, 11, 1, 1, 1, 1, 1, 1, 11, 11, 11; ...
    1, 1, 22, 23, 24, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 6, 1, 1, 1, 1, 5, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 1; ...
    7, 1, 1, 6, 1, 5, 1, 1, 1, 1, 1; ...
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

drawScene(scn, bottomL, topL);
topL(frogPos(1), frogPos(2)) = 2;
% Game loop - runs the game continuously
while true
    alligatorMoveCounter = alligatorMoveCounter + 1; % Increment the alligator movement counter

    % Move alligators at the specified frequency
    if alligatorMoveCounter == alligatorMoveFrequency
        alligatorMoveCounter = 0; % Reset the counter

        % Update positions of alligators on the grid
        for i = 1:size(alligators, 1)
            % Clear the previous alligator positions
            topL(alligators(i, 1), alligators(i, 2):alligators(i, 2) + 2) = 1;
            % Move the alligator one step to the right
            alligators(i, 2) = alligators(i, 2) + 1;
            % Display the alligator in its new position
            topL(alligators(i, 1), alligators(i, 2):alligators(i, 2) + 2) = alligatorSymbols;
        end
    end

    % Check if the frog collides with an alligator
    for i = 1:size(alligators, 1)
        if frogPos(1) == alligators(i, 1) && any(frogPos(2) >= alligators(i, 2) && frogPos(2) <= alligators(i, 2) + 2)
            % Reset frog position and update grid
            topL(frogPos(1), frogPos(2)) = 1;
            frogPos = [11, 6];
            topL(frogPos(1), frogPos(2)) = 2;
        end
    end

    % Draw the game scene
    drawScene(scn, bottomL, topL);
    xlabel(sprintf('points: %d', points)); % Display points in the plot
    title('Frogger') % Set the game title

    % Update frog position and points based on movement and reaching the top
    if ((frogPos(2) == 2 || frogPos(2) == 4 || frogPos(2) == 6 || frogPos(2) == 8 || frogPos(2) == 10) && frogPos(1) == 1)
        oldPos = frogPos(2);
        frogPos = [11, 6];
        topL(1, oldPos) = 14; % Place a marker on the log
        points = points + 1; % Increment points
        frogPos = [11, 6]; % Reset frog position
        topL(frogPos(1), frogPos(2)) = 2; % Update frog position
    elseif points == 5
        xlabel(sprintf('GAME OVER!!! points: %d', points)); % Display points in the plot
        drawScene(scn, blankL);

    end

    % Get keyboard input and move the frog accordingly
    k = getKeyboardInput(scn);
    if strcmp(k, 'uparrow') && (frogPos(1) ~= 1)
        % Move the frog up
        topL(frogPos(1), frogPos(2)) = 1;
        frogPos(1) = frogPos(1) - 1;
        topL(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'downarrow') && (frogPos(1) ~= 11)
        % Move the frog down
        topL(frogPos(1), frogPos(2)) = 1;
        frogPos(1) = frogPos(1) + 1;
        topL(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'rightarrow') && (frogPos(2) ~= 11)
        % Move the frog right
        topL(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) + 1;
        topL(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'leftarrow') && (frogPos(2) ~= 1)
        % Move the frog left
        topL(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) - 1;
        topL(frogPos(1), frogPos(2)) = 2;
    end

    pause(0.05); % Pause to control the game speed
end