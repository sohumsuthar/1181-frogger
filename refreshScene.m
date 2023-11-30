function refreshScene()
global points;
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
    topL(6, 6) = 1;
    bottomL(6, 6) = 1;
    speed = 0.1;

end

onesDigitP = onesDigit(points);
tensDigitP = tensDigit(points);
onesDigitL = onesDigit(level);
tensDigitL = tensDigit(level);
blankL(12,:) = [33, numPref(tensDigit(points)), numPref(onesDigit(points)), 1, 55, numPref(tensDigit(level)), numPref(onesDigit(level)), 1, 32, numPref(tensDigit(lives)), numPref(onesDigit(lives))];


drawScene(scn, bottomL, topL, blankL);

figure(f);
end

