clc
clear
close all

global speed;

initVars();
startScreen();

% Add a pause to refresh scene and sprite movement
while true
    movementSpriteControl();
    refreshScene();
    pause(speed);
end


