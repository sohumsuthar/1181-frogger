clc
clear
close all

global speed;
global gameOver;
global Timer;

initVars();
startScreen();

% Add a pause to refresh scene and sprite movement
while true
tic;
while ~gameOver
    movementSpriteControl();
    refreshScene();
    pause(speed);
end
Timer = toc;
restartGame();
end

