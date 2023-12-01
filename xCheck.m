function xCheck()
global topL;
global frogPos;
global enemies;

[y1, Fs1] = audioread('sound-frogger-squash.wav');
[y2, Fs2] = audioread('sound-frogger-plunk.wav');

% Reset the frog's position if it gets hit by an enemy
if (ismember(topL(frogPos(1), frogPos(2)), enemies))
    sound(y1, Fs1);
    resetFrogPos(true);
elseif ((frogPos(1) >= 2 && frogPos(1) <= 5) && topL(frogPos(1), frogPos(2)) == 1)
    sound(y2, Fs2)
    resetFrogPos(true);
end
end