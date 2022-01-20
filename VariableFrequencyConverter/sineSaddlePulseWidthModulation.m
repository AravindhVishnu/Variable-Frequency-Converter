function [ccrA,ccrB,ccrC] = sineSaddlePulseWidthModulation(freqDes, ctrl)
% Generate Sine or Saddle waveforms using a linear Volts per Hertz profile

persistent t_cnt

if isempty (t_cnt)
    t_cnt = 0;
end

TWO_PI = 2*pi;
TWO_DIV_SQRT_THREE = 2/sqrt(3);

if (ctrl.method == 1)  % Sine
    slope = 1 / ctrl.freqNom;
else  % Saddle
    slope = TWO_DIV_SQRT_THREE / ctrl.freqNom;
end

% Open loop Volts per Hertz control
f_des = freqDes * ctrl.freqNom;
v_des = slope * f_des;

if (f_des < ctrl.minFrequency)
    f_des = ctrl.minFrequency;
end

% Calculate number of executions corresponding to the desired frequency
period_cnt = round(1/(f_des*ctrl.deltaControlProcess));

% reference angle for the three phase sine waves
phi = TWO_PI * ctrl.deltaControlProcess * f_des * t_cnt;

% wrap the counter at every end of the period
t_cnt = t_cnt + 1;
if (t_cnt >= period_cnt)
    t_cnt = 0;
end

% phase a angle
phase_a_angle = phi;
if (phase_a_angle > TWO_PI) 
    phase_a_angle = phase_a_angle - TWO_PI;
elseif (phase_a_angle < 0) 
    phase_a_angle = phase_a_angle + TWO_PI;
else
    % no change in the value of phase_a_angle
end

% phase b angle is shifted 2*PI/3 radians (120 degrees)
phase_b_angle = phi - (TWO_PI/3);
if (phase_b_angle > TWO_PI) 
    phase_b_angle = phase_b_angle - TWO_PI;
elseif (phase_b_angle < 0) 
    phase_b_angle = phase_b_angle + TWO_PI;
else
    % no change in the value of phase_b_angle
end

% phase b angle is shifted 4*PI/3 radians (240 degrees)
phase_c_angle = phi - ((2*TWO_PI)/3);
if (phase_c_angle > TWO_PI) 
    phase_c_angle = phase_c_angle - TWO_PI;
elseif (phase_c_angle < 0) 
    phase_c_angle = phase_c_angle + TWO_PI;
else
    % no change in the value of phase_c_angle
end

if (ctrl.method == 1)  % Sine
    va = v_des * sin(phase_a_angle);
    vb = v_des * sin(phase_b_angle);
    vc = v_des * sin(phase_c_angle);
else  % Saddle
    v_des_third_harmonic = v_des / 6;
    va3 = v_des_third_harmonic*sin(3*phase_a_angle);
    vb3 = v_des_third_harmonic*sin(3*phase_b_angle);
    vc3 = v_des_third_harmonic*sin(3*phase_c_angle);
    va = v_des * sin(phase_a_angle) + va3;
    vb = v_des * sin(phase_b_angle) + vb3;
    vc = v_des * sin(phase_c_angle) + vc3;
end

% Convert to us
ccrA = ((va + 1) / 2) * ctrl.timerARR;
if (ctrl.rotationDirection == 1)  % Forward
    ccrB = ((vb + 1) / 2) * ctrl.timerARR;
    ccrC = ((vc + 1) / 2) * ctrl.timerARR;
else  % Reverse
    ccrB = ((vc + 1) / 2) * ctrl.timerARR;
    ccrC = ((vb + 1) / 2) * ctrl.timerARR;
end
