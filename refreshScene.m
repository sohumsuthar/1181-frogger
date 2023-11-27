function refreshScene()
global points;
global frogPos;
global topL;
global scn;
global bottomL;
global blankL
global f;
global lives;

% If the frog's lives become zero, refresh scene with GAME OVER sprites on
% the blank layer

if lives == 0
    % text(200, 200, 'GAME OVER', 'FontSize', 32, 'Color', 'w')
    blankL(6, :) = [1, 25, 26, 27, 28, 1, 29, 30, 28, 31, 1];
    % xlabel(sprintf('points: %d, lives %d', points, lives)); % Display points in the plot
    % topL(7, :) = [1, 35, 36, 37, 38, 1, 39, 40, 39, 41, 1];
    % bottomL(7, :) = [1, 35, 36, 37, 38, 1, 39, 40, 39, 41, 1];
end
% if points < 10
%     blankL(12,:) = [33, 41, numPref(points), 1, 1, 1, 1, 1, 1, 32, numPref(lives)];
% 
% elseif points >= 10
    onesDigit = mod(points, 10);
    tensDigit = floor(mod(points, 100) / 10);
    blankL(12,:) = [33, numPref(tensDigit), numPref(onesDigit), 1, 1, 1, 1, 1, 1, 32, numPref(lives)];
% 
% end

drawScene(scn, bottomL, topL, blankL);

% title('Frogger') % Set the game title
figure(f);
end

