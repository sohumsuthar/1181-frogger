clc
clear
close all
clear sound
clear player

global speed;
global gameOver;
global Timer;

initVars();
startScreen();

[y, Fs] = audioread('kensample.mp3');
volume = 0.4;
player = audioplayer(volume * y, Fs);


% Add a pause to refresh scene and sprite movement
while true
tic;
play(player);
while ~gameOver
    if ~isplaying(player)
        play(player);
    end
    movementSpriteControl();
    refreshScene();
    pause(speed);
end

Timer = toc;
restartGame();
end

