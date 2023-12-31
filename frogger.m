% clear everything
clc
clear
close all
clear sound
clear player

% global initializations
global speed; % pause speed
global gameOver; % bool for game over state
global Timer; % timer for trophy
global player; % player for song

initVars(); % initialize the game
startScreen(); % display the start screen


% Add a pause to refresh scene and sprite movement
while true
    tic; % start the timer for the trophy
    play(player); % play the background music
    while ~gameOver % in the current game session
        movementSpriteControl(); % move the sprites that need to be moved
        refreshScene(); % refresh the scene and publish the scene to the fgr
        pause(speed); % wait
    end

    Timer = toc; % set timer
    restartGame(); % reset vars for new game
end

