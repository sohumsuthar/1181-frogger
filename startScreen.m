function startScreen()
global scn;
global X;
global Y;
global Z;
global blankL;
global frogPos;
drawScene(scn, X, Y, Z);
getMouseInput(scn);
% Scene labels and titles
refreshScene();
blankL(frogPos(1), frogPos(2)) = 2;
end