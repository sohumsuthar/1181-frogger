% function to check whether the frog dies or not
function xCheck()

% see function 'initVars' for all variable informations
% global variable initializations
global topL;
global frogPos;
global enemies;

% read audio files for frog death sounds
[y1, Fs1] = audioread('sound-frogger-squash.wav');
[y2, Fs2] = audioread('sound-frogger-plunk.wav');

% Reset the frog's position if it gets hit by an enemy
if (ismember(topL(frogPos(1), frogPos(2)), enemies)) % if the frog position in the top layer is an enemy sprite:
    sound(y1, Fs1); % play death sound
    resetFrogPos(true); % loss is true
elseif ((frogPos(1) >= 2 && frogPos(1) <= 5) && topL(frogPos(1), frogPos(2)) == 1) % if the frog is in the water
    sound(y2, Fs2) % play death sound for water
    resetFrogPos(true); 
end
end