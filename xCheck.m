function xCheck()
global topL;
global frogPos;
global enemies;
            if (ismember(topL(frogPos(1), frogPos(2)), enemies)) || ((frogPos(1) >= 2 && frogPos(1) <= 5) && topL(frogPos(1), frogPos(2)) == 1);

                resetFrogPos(true);
            end
end