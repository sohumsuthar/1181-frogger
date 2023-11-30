clc
clear
close all

global speed;

initVars();
startScreen();

% Add pause to scene refresh
while true
    movementSpriteControl();
    refreshScene();
    pause(speed);
end


