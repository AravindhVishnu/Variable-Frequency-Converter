function [ccrA, ccrB, ccrC] = spaceVectorPulseWidthModulation(freqDes, ctrl)
% Generate space vector waveforms using a linear Volts per Hertz profile

PHI_DIV_THREE = pi / 3;

persistent k
persistent phi_p

if isempty (k)
    k = 1;
    phi_p = 0;
end

% Open loop Voltz per Hertz control
slope = 1 / ctrl.freqNom;
f_des = freqDes * ctrl.freqNom;
v_des = slope * f_des;
if (f_des < ctrl.minFrequency)
   f_des = ctrl.minFrequency;
end

phi_p = (2 * pi * f_des * ctrl.deltaControlProcess) + phi_p;

if (phi_p >= PHI_DIV_THREE)
    phi_p = phi_p - PHI_DIV_THREE;
    
    % Determine sector
    k = k + 1;
    if (k > 6)
        k = 1;
    end
end

phi_p_p = PHI_DIV_THREE - phi_p;

d_a = v_des * sin(phi_p);
d_b = v_des * sin(phi_p_p);

switch (k)
    case 1
        c_a = -d_a - d_b;
        c_b = -d_a + d_b;
        c_c = d_a + d_b;
    case 2
        c_a = d_a - d_b;
        c_b = -d_a - d_b;
        c_c = d_a + d_b;        
    case 3
        c_a = d_a + d_b;
        c_b = -d_a - d_b;
        c_c = -d_a + d_b;         
    case 4
        c_a = d_a + d_b;
        c_b = d_a - d_b;
        c_c = -d_a - d_b;           
    case 5
        c_a = -d_a + d_b;
        c_b = d_a + d_b;
        c_c = -d_a - d_b;         
    case 6
        c_a = -d_a - d_b;
        c_b = d_a + d_b;
        c_c = d_a - d_b;       
    otherwise
        c_a = 0;
        c_b = 0;
        c_c = 0;
end

% Calculate compare register values
ccr_a = (1 + c_a) / (4 * ctrl.pwmFrequency);
ccr_b = (1 + c_b) / (4 * ctrl.pwmFrequency);
ccr_c = (1 + c_c) / (4 * ctrl.pwmFrequency);

% Convert to us
ccrA = ccr_a * 1e6;
if (ctrl.rotationDirection == 1)  % Forward
    ccrB = ccr_b * 1e6;
    ccrC = ccr_c * 1e6;
else  % Reverse
    ccrB = ccr_c * 1e6;
    ccrC = ccr_b * 1e6;
end
