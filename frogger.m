clc
clear
close all
clear sound
clear player

global speed;
global gameOver;
global Timer;
global player;

initVars();
startScreen();


% Add a pause to refresh scene and sprite movement
while true
tic;
play(player);
while ~gameOver
    movementSpriteControl();
    refreshScene();
    pause(speed);
end

Timer = toc;
restartGame();
end

