function refreshScene()
global points;
global frogPos;
global topL;
global scn;
global bottomL;
global blankL
global f;
global lives;

if points < 5
    xlabel(sprintf('points: %d, lives %d', points, lives)); % Display points in the plot
else points == 5
    text(200, 200, 'GAME OVER', 'FontSize', 32, 'Color', 'w')
end
drawScene(scn, bottomL, topL, blankL);

title('Frogger') % Set the game title
figure(f);
end

