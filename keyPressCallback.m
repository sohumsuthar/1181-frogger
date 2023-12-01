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
