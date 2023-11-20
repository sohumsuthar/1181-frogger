function keyPressCallback(event)
global points;
global frogPos;
global topL;
global scn;
global bottomL;
global blankL
global f;
global bushPos;

k = event.Key;
switch (k)
    case 'uparrow' 
        if (frogPos(1) ~= 1) && ~((ismember(frogPos(2), bushPos) && frogPos(1) == 2))
        % Move the frog up
        blankL(frogPos(1), frogPos(2)) = 1;
        frogPos(1) = frogPos(1) - 1;
        blankL(frogPos(1), frogPos(2)) = 2;
        gameEndCheck();
        refreshScene();
        end
    case 'downarrow'
        if (frogPos(1) ~= 11)
        % Move the frog downe
        blankL(frogPos(1), frogPos(2)) = 1;
        frogPos(1) = frogPos(1) + 1;
        blankL(frogPos(1), frogPos(2)) = 2;
        refreshScene();
        end
    case 'rightarrow'
        if (frogPos(2) ~= 11)
        % Move the frog right
        blankL(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) + 1;
        blankL(frogPos(1), frogPos(2)) = 2;
        refreshScene();
        end
    case 'leftarrow' 
        if (frogPos(2) ~= 1)
        % Move the frog left
        blankL(frogPos(1), frogPos(2)) = 1;
        frogPos(2) = frogPos(2) - 1;
        blankL(frogPos(1), frogPos(2)) = 2;
        refreshScene();
        end 
end
pause(.5)
end