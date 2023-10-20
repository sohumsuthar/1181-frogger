close all;

% Create a figure for the game window
figure('Name', 'frogger', 'NumberTitle', 'off');

% Set game parameters (e.g., screen size, frame rate, etc.)
screenWidth = 1000;
screenHeight = 800;
frameRate = 30;

% Load your sprite sheet
spriteSheet = imread('gameSprites.png');

% Define sprite positions
spritePositions = [100, 100]; % Example position
spriteWidth = 15; % Width of the sprite
spriteHeight = 15; % Height of the sprite

while ishandle(1)  % This loop continues as long as the game window is open
    % Update game logic here

    % Clear the figure to prepare for the next frame
    clf;
    
    % Draw the sprite
    x = spritePositions(1);
    y = spritePositions(2);
    
    % Extract and display the sprite (positions (0, 0) to (14, 14))
    startX = 1; % Starting X position on the sprite sheet
    endX = spriteWidth;
    startY = 1; % Starting Y position on the sprite sheet
    endY = spriteHeight;
    
    sprite = spriteSheet(startY:endY, startX:endX, :);
    
    % Display the sprite at the specified position (x, y)
    imshow(sprite, 'XData', [x x+spriteWidth], 'YData', [y y+spriteHeight]);
    hold on;
    
    % Pause to control the frame rate
    pause(1 / frameRate);
end
