% Idk what to comment here

function result = numPref(value)
    if value == 0
        result = 41;
    elseif value == 9
        result = 50;
    else
        result = str2double(['4', num2str(value +1)]);
    end
end
