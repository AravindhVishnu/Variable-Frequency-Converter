function [T1,T2,T3,T4,T5,T6] = gateSignalGenerator(pwmIn1, pwmIn2, pwmIn3)

if (pwmIn1) 
    T1 = 1;
    T2 = 0;
else
    T1 = 0;
    T2 = 1;
end

if (pwmIn2) 
    T3 = 1;
    T4 = 0;
else
    T3 = 0;
    T4 = 1;
end

if (pwmIn3) 
    T5 = 1;
    T6 = 0;
else
    T5 = 0;
    T6 = 1;
end

% Prevent SC
if (T1 && T2)
   T1 = 0;
   T2 = 0;
end

if (T3 && T4)
   T3 = 0;
   T4 = 0;
end

if (T5 && T6)
   T5 = 0;
   T6 = 0;
end
