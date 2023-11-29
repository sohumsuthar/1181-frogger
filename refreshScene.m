function refreshScene()
global points;
global frogPos;
global topL;
global scn;
global bottomL;
global blankL
global f;
global lives;
global speed;
global level;

% If the frog's lives become zero, refresh scene with GAME OVER sprites on
% the blank layer

if lives == 0
    blankL(6, :) = [1, 25, 26, 27, 28, 1, 29, 30, 28, 31, 1];
    speed = 0.1;

end

onesDigitP = onesDigit(points);
tensDigitP = tensDigit(points);
onesDigitL = onesDigit(level);
tensDigitL = tensDigit(level);
blankL(12,:) = [33, numPref(tensDigitP), numPref(onesDigitP), 1, 55, numPref(tensDigitL), numPref(onesDigitL), 1,1, 32, numPref(lives)];


drawScene(scn, bottomL, topL, blankL);

figure(f);
end

