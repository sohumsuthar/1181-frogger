% function tp reset the frog position and handle losses

function resetFrogPos(loss) % boolean for whether the player lost a life or not

% see function 'initVars' for all variable informations
% global variable initializations
global points;
global frogPos;
global blankL
global lives;
global defaultBlank;

% Reset the frog position after dying or completing the level
frogPos = [11, 6];

% Update frog position, number of lives, and/or amount of points
% Refresh scene at the end of each iteration

blankL(frogPos(1), frogPos(2)) = 2; % print frog at default position

if loss % if loss
    if lives ~= 0
        % decrement lives if lives are not 0
        lives = lives - 1;
    end

else
    % if not, increment the points
    points = points + 1;
end

blankL = defaultBlank; % reset the blank layer

refreshScene(); % refresh the scene

end