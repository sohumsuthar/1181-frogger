clc
clear
close all

global speed;
global gameOver;


initVars();
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

