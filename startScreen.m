% Draws scene with the start menu components such as the game title,
% character sprites, and the mouse input to allow the user to press START
function startScreen()

% see function 'initVars' for all variable informations
% global variable initializations

global scn;
global X;
global Y;
global Z;
global blankL;
global frogPos;

% Draw start menu scene and initialize mouse input
drawScene(scn, X, Y, Z);
getMouseInput(scn);

% refresh scene with new blank layer
refreshScene();
blankL(frogPos(1), frogPos(2)) = 2;

end