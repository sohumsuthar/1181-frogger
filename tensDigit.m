% Returns the tens digit of the inputed value
function tens = tensDigit(value)

tens = floor(mod(value, 100) / 10);

end