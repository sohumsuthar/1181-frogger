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
    blankL(6, :) = [1, 25, 26, 27, 28, 1, 29, 30, 28, 31, 1];

end

onesDigit = mod(points, 10);
tensDigit = floor(mod(points, 100) / 10);
blankL(12,:) = [33, numPref(tensDigit), numPref(onesDigit), 1, 1, 1, 1, 1, 1, 32, numPref(lives)];


drawScene(scn, bottomL, topL, blankL);

figure(f);
end

