clc
clear
close all

global speed;
global gameOver;


initVars();
disp(['Hello!, this is Frogger. The objective is to fill in all the homes across ' ...
    'the river without falling in the water, \n' ...
    'getting eaten by a croc, getting run over, and dying to an otter!\n' ...
    'Once you fill all the spots, the game will progressivley get harder and faster,\n' ...
    'granting you a life for filling the homes.\n' ...
    'Good luck and have fun!'])
startScreen();

% Add a pause to refresh scene and sprite movement
while true
while ~gameOver
    movementSpriteControl();
    refreshScene();
    pause(speed);
end
restartGame();
end

