% a function to handle the game restarting after the game has ended

function restartGame()

% see function 'initVars' for all variable informations
% global variable initializations

global gameOver;
global scn;
global points
global Timer;



fileID = fopen('score_trophy.txt', 'w'); % access or create a file named score_trophy.txt to contain 
% the final score and time receieved by the user before the game ended
fprintf(fileID, 'Score: %d\n Time: %.2f\n', points, Timer); % write points and time to the file
fclose(fileID); % close the file

fprintf('Score saved to score_trophy.txt'); % show that the final score and time has been saved

pause(1); % pause for a second to avoid lag

getMouseInput(scn); % wait for mouse input for progress on the game over screen

close all; % close all figures

gameOver = false; % reset the boolean state of the gameOver variable
initVars(); % re-initialize the variables for the next game 
resetFrogPos(false); % reset the frog position
points = 0; % initialize the points to 0

end

