function letter = letterIndex(value)
% Insert start menu letters
if strcomp(value, 's')
    letter = 51;
elseif strcomp(value, 't')
    letter = 52;
elseif strcomp(value, 'g')
    letter = 25;
elseif strcomp(value, 'a')
    letter = 26;
elseif strcomp(value, 'm')
    letter = 27;
elseif strcomp(value, 'e')
    letter = 28;
elseif strcomp(value, 'o')
    letter = 29;
elseif strcomp(value, 'v')
    letter = 30;
elseif strcomp(value, 'r')
    letter = 31;
end
end