%% --- Clear the workspace and the command window ---
% All variables in the workspace are erased, all figures are closed and the console is cleaned
clear all
close all
clc

%% --- Motor Model ---
mot_from_on = 0;                        % 0 = Motor starts from zero speed, 1 = motor starts from full speed
connection = 1;                         % 0 = Delta-connected motor, 1 = Wye-connected motor, don't forget to change the connections in the simulation model
motor1;                                 % Use motor1
createMotorstructure;                   % Upload all the parameters from the motor m-file
disp(['Motor: ' motor.motor_name]);     % Display the name of the motor that is currently in use in the command window
R_Convergence = (motor.un*1000)/(motor.In*sqrt(2)); % Open stator windings motor convergence resistance

%% --- Simulation settings ---
simCtrl.startTime = 0;  % Simulation start time
simCtrl.endTime = 9;    % Simulation end time

%% --- Controller settings ---
ctrl.method = 3;                                  % PWM modulation method (1 = Sine PWM, 2 = Saddle PWM, 3 = Space vector PWM)
ctrl.deltaControlProcess = 25e-6;                 % Execution time interval for the controller [s]
ctrl.pwmFrequency = 2000;                         % Carrier signal frequency [Hz]
ctrl.freqNom = 50;                                % Nominal frequency [Hz]
ctrl.minFrequency = 3;                            % Minimal allowed frequency [Hz]
ctrl.timerARR = (1e6) / (2 * ctrl.pwmFrequency);  % Timer auto-reload value in center-aligned mode [us]
ctrl.rotationDirection = 1;                       % Motor rotation direction (1 = Forward, 2 = Reverse)

%% --- Ramp settings ---
ctrl.startRamp.time = 4;                                            % V/Hz start ramp time [s]
ctrl.stopRamp.time = 4;                                             % V/Hz stop ramp time [s]
ctrl.startRamp.inc = ctrl.deltaControlProcess/ctrl.startRamp.time;  % Increment
ctrl.stopRamp.dec = ctrl.deltaControlProcess/ctrl.stopRamp.time;    % Decrement
ctrl.currentLimitFactor = 1.05;                                     % Current limit factor

%% --- Grid ---
Vnet = motor.Vn;                        % RMS Line (phase to phase) voltage [V]
Inet = motor.In;                        % Rated current (nominal line current) [A]
global fnet;
fnet = motor.fn;                        % Nominal frequency [Hz]
ctrl.fnet = motor.fn;

% Grid parameters: Amplitude, bias, angular frequency [rad/s] and phase displacement [rad]
% Phase A
PhaseA_Grid_Amplitude = sqrt(2)*Vnet / sqrt(3);
PhaseA_Grid_Bias = 0;
PhaseA_Grid_Frequency = 2*pi*fnet;
PhaseA_Grid_Phase = 0;

% Phase B (L2)
PhaseB_Grid_Amplitude = sqrt(2)*Vnet / sqrt(3);   
PhaseB_Grid_Bias = 0;                            
PhaseB_Grid_Frequency = 2*pi*fnet;               
PhaseB_Grid_Phase = -2*pi/3;                     

% Phase C (L3)
PhaseC_Grid_Amplitude = sqrt(2)*Vnet / sqrt(3);   
PhaseC_Grid_Bias = 0;
PhaseC_Grid_Frequency = 2*pi*fnet;  
PhaseC_Grid_Phase = -4*pi/3;

%% --- Load ---
TconstP = 0;                        % Contribution to the load torque constant with the speed [ p. u.]
TlinP = 0;                          % Contribution to the load torque linear with the speed [ p. u.]
TsqP = 1;                           % Contribution to the load torque quadratic with the speed [ p. u.]
TcuP = 0;                           % Contribution to the load torque cubic with the speed [ p. u.]

if (ctrl.rotationDirection ~= 1)
    TconstP = -1 * TconstP;
    TlinP = -1 * TlinP;
    TsqP = -1 * TsqP;
    TcuP = -1 * TcuP;
end

w_nom = (2*pi/60)*motor.rpm_nom;    % Nominal angular velocity [rad/s]

%%
disp('Model parametrers initialized');    % Display that all the parameters have been initialized in the command window
