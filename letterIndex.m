% Function that creates letter sprites necessary for start menu screen to
% say START and GAME OVER at the end of the game
function letter = letterIndex(value)

% Insert start menu letters
if strcmp(value, 's')
    letter = 51;

elseif strcmp(value, 't')
    letter = 52;

elseif strcmp(value, 'g')
    letter = 25;

elseif strcmp(value, 'a')
    letter = 26;

elseif strcmp(value, 'm')
    letter = 27;

elseif strcmp(value, 'e')
    letter = 28;

elseif strcmp(value, 'o')
    letter = 29;

elseif strcmp(value, 'v')
    letter = 30;

elseif strcmp(value, 'r')
    letter = 31;

end
end