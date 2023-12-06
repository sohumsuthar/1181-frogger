% Function that updates the players lives and points when refreshing the
% scene or refreshes the scene to GAME OVER layer if the lives are zero
function refreshScene()

% see function 'initVars' for all variable information
global points;
global topL;
global scn;
global bottomL;
global blankL
global f;
global lives;
global speed;
global level;
global gameOver;
global player;

% If the frog's lives become zero, refresh scene with GAME OVER and START sprites on
% the blank layer
if ~isplaying(player)
    play(player);
end

if lives == 0
    blankL(6, :) = [1, 25, 26, 27, 28, 1, 29, 30, 28, 31, 1];
    blankL(9, :) = [1, 1, 1, letterIndex('s'), letterIndex('t'), letterIndex('a'),...
        letterIndex('r'), letterIndex('t'), 1, 1, 1];
    topL(6, 6) = 1;
    bottomL(6, 6) = 1;
    speed = 0.1;
    gameOver = true;

end

onesDigitP = onesDigit(points);
tensDigitP = tensDigit(points);
onesDigitL = onesDigit(level);
tensDigitL = tensDigit(level);
blankL(12,:) = [33, numPref(tensDigit(points)), numPref(onesDigit(points)), 1, 55, numPref(tensDigit(level)), numPref(onesDigit(level)), 1, 32, numPref(tensDigit(lives)), numPref(onesDigit(lives))];

% Draw scene with new blank layer
drawScene(scn, bottomL, topL, blankL);

figure(f);
end

