function restartGame()
global gameOver;
global scn;
global points

pause(1);
getMouseInput(scn);
close all;
gameOver = false;
initVars();
resetFrogPos(false);
points = 0;
end