clc
clear
close all


scn = simpleGameEngine('frogger.png', 16, 16, 5, [0,0,0]);
frogPos = [1, 2];
sceneMatrix = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

sceneMatrix(frogPos(1), frogPos(2)) = 2;
while true
    drawScene(scn,sceneMatrix);
    k = getKeyboardInput(scn);
    if k == 'uparrow'
        sceneMatrix(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) + 1;
        sceneMatrix(frogPos(1), frogPos(2)) = 2;
    end

end





