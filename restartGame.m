function restartGame()
global gameOver;
global scn;
global points


fprintf('')
fileID = fopen('score_trophy.txt', 'w');
fprintf(fileID, 'Score: %d\n', points);
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