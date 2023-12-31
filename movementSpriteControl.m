% function to control the movement of the sprites that traverse the road
% and river

function movementSpriteControl()

% see function 'initVars' for all variable informations
% global variable initializations
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

for i = movementRows % for each row that moves

    if mod(i, 2) == 1 || i == 6 % if its an odd row or if its the row containing the snake,

        % if the frog is on the row and is not touching an enemy or the
        % water:
        if frogPos(1) == i && (~ismember(topL(i, frogPos(2)), enemies) && topL(i, frogPos(2)) ~= 1)

            frogPos(2) = frogPos(2) - shiftAmount; % shift the frog position

            if frogPos(2) == 0 % if the frog is in an illegal position, 
                % decrement lives and reset its position

                resetFrogPos(true);

            else
                % else: print updated result to layer given that the frog
                blankL(i, :) = circshift(blankL(i, :), [0, -shiftAmount]);
                refreshScene(); % refresh the scene 
            end

        elseif frogPos(1) == i && (ismember(topL(i, frogPos(2)), enemies) ...
                ||  bottomL(i, frogPos(2)) == 21) % if the frog is touching an enemy
            resetFrogPos(true); % reset frog position and decrement lives by one
        end

        % finally, shift the entire top layer
        topL(i, :) = circshift(topL(i, :), [0, -shiftAmount]); 


    else % repeat all above steps if the row is an even row

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

xCheck(); % check for frog death

refreshScene(); % refresh the scene
end