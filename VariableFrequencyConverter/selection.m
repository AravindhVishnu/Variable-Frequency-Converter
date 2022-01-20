function [spaceVectorPWM,sineSaddlePWM] = selection(method)

if (method == 1 || method == 2)
    sineSaddlePWM = 1;
    spaceVectorPWM = 0;
elseif (method == 3)
    sineSaddlePWM = 0;
    spaceVectorPWM = 1;
else
    sineSaddlePWM = 0;
    spaceVectorPWM = 0;
end

end