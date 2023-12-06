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
