clc
clear
close all


scn = simpleGameEngine('frogger.png', 16, 16, 5, [0,0,0]);
frogPos = [4, 2];
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
    if strcmp(k, 'uparrow') && (frogPos(1) ~= 1)
        sceneMatrix(frogPos(1), frogPos(2)) = 1;
        frogPos(1) = frogPos(1) - 1;
        sceneMatrix(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'downarrow') && (frogPos(1) ~= 9)
        sceneMatrix(frogPos(1), frogPos(2)) = 1;
        frogPos(1) = frogPos(1) + 1;
        sceneMatrix(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'rightarrow') && (frogPos(2) ~= 11)
        sceneMatrix(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) + 1;
        sceneMatrix(frogPos(1), frogPos(2)) = 2;
    elseif strcmp(k, 'leftarrow') && (frogPos(2) ~= 1)
        sceneMatrix(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) - 1;
        sceneMatrix(frogPos(1), frogPos(2)) = 2;

    end
   pause(0.1);
end





