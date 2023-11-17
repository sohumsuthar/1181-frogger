function keyPressCallback(event)
global points;
global frogPos;
global topL;
global scn;
global bottomL;
global blankL
global f;

k = event.Key;

if strcmp(k, 'uparrow') && (frogPos(1) ~= 1)
    % Move the frog up
    blankL(frogPos(1), frogPos(2)) = 1;
    frogPos(1) = frogPos(1) - 1;
    blankL(frogPos(1), frogPos(2)) = 2;

elseif strcmp(k, 'downarrow') && (frogPos(1) ~= 11)
    % Move the frog downe
    blankL(frogPos(1), frogPos(2)) = 1;
    frogPos(1) = frogPos(1) + 1;
    blankL(frogPos(1), frogPos(2)) = 2;

elseif strcmp(k, 'rightarrow') && (frogPos(2) ~= 11)
    % Move the frog right
    blankL(frogPos(1), frogPos(2)) = 1;
    frogPos(2) = frogPos(2) + 1;
    blankL(frogPos(1), frogPos(2)) = 2;
elseif strcmp(k, 'leftarrow') && (frogPos(2) ~= 1)
    % Move the frog left
    blankL(frogPos(1), frogPos(2)) = 1;
    frogPos(2) = frogPos(2) - 1;
    blankL(frogPos(1), frogPos(2)) = 2;
end
drawScene(scn, bottomL, topL, blankL);
xlabel(sprintf('points: %d', points)); % Display points in the plot
title('Frogger') % Set the game title
figure(f);
end