function restartGame()
global gameOver;
global scn;
global points
global Timer;


fprintf('')
fileID = fopen('score_trophy.txt', 'w');
fprintf(fileID, 'Score: %d\n Time: %.2f\n', points, Timer);
fclose(fileID);

disp('Score saved to score_trophy.txt');

pause(1);
getMouseInput(scn);
close all;
gameOver = false;
initVars();
resetFrogPos(false);
points = 0;
end