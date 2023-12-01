function movementSpriteControl()
global frogPos;
global topL;
global bottomL;
global blankL
global movementRows;
global shiftAmount;
global enemies;

% Circularily shift the positions of the sprites unless it has reached one
% side of the sceen and if so, restart its position at the other end of the screen
% Refresh scene and/ or frog position after each iteration
for i = movementRows
    if mod(i, 2) == 1 || i == 6 || i == 8

        if frogPos(1) == i && (~ismember(topL(i, frogPos(2)), enemies) && topL(i, frogPos(2)) ~= 1)

            frogPos(2) = frogPos(2) - shiftAmount;
            if frogPos(2) == 0
                resetFrogPos(true);
            else
                blankL(i, :) = circshift(blankL(i, :), [0, -shiftAmount]);
                refreshScene();
            end
        elseif frogPos(1) == i && (ismember(topL(i, frogPos(2)), enemies) ||  bottomL(i, frogPos(2)) == 21)
            resetFrogPos(true);
        end
        topL(i, :) = circshift(topL(i, :), [0, -shiftAmount]);
    else

        if frogPos(1) == i && (~ismember(topL(i, frogPos(2)), enemies) && topL(i, frogPos(2)) ~= 1)

            frogPos(2) = frogPos(2) + shiftAmount;
            if frogPos(2) == 12
                resetFrogPos(true);
            else
                blankL(i, :) = circshift(blankL(i, :), [0, shiftAmount]);
                refreshScene();
            end
        elseif frogPos(1) == i && (ismember(topL(i, frogPos(2)), enemies) ||  bottomL(i, frogPos(2)) == 21)
            resetFrogPos(true);

        end
        topL(i, :) = circshift(topL(i, :), [0, shiftAmount]);
    end

end
xCheck();
refreshScene();
end