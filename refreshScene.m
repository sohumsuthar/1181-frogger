function refreshScene()
global points;
global frogPos;
global topL;
global scn;
global bottomL;
global blankL
global f;
global lives;

drawScene(scn, bottomL, topL, blankL);
xlabel(sprintf('points: %d, lives %d', points, lives)); % Display points in the plot
title('Frogger') % Set the game title
figure(f);
end

