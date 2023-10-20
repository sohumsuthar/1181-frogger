function spriteIndex = calculateSpriteIndex(spriteNumber)
    % Implement your logic here to determine the sprite index
    % For example, you might cycle through a list of sprite indices.
    
    % For simplicity, let's assume we cycle through sprites 1 to 3.
    numSprites = 3;
    spriteIndex = mod(spriteNumber, numSprites) + 1;
end
