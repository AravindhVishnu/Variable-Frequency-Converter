% Motor 1

motor_name = 'motor1';

% Basic motor data

if connection
% Wye connected motor    
    un = 400/sqrt(3);                   % Phase voltage Wye-connected [V]
    in = 84.67904;                      % Line current Wye-connected [A]
    In = 84.67904;                      % Phase current Wye-connected [A]
    Vn = sqrt(3)*un;                    % Line voltage Wye connected [V]
else
% Delta connected motor
    un = 400/sqrt(3);                   % Phase voltage Delta-connected [V]
    in = 84.67904*sqrt(3);              % Line current Delta-connected [A]
    In = 84.67904;                      % Phase current Delta-connected [A]
    Vn = un;                            % Line voltage Delta-connected [V]
end

% Motor parameters
fn = 50;                                % Grid frequency [Hz]
wb = 2*pi*fn;                           % Synchronous angular velocity [rad/s]
np = 2;                                 % Number of pole pairs [#]
jm = 0.7226001;                         % Motor inertia [kg*m^2]
Pn = 3*un*In;                           % Nominal power [W]     
Tl_nom = 321.9;                         % Nominal torque [Nm]
rpm_nom = 1484;                         % Nominal speed [rpm]
b = 0;                                  % Friction factor

% Motor equivelent circuit parameters
rs = 0.0528;                            % Stator resistance [Ohm]
lsl = 0.2210005/wb;                     % Stator inductance [H]
lrl = 0.2108066/wb;                     % Rotor inductance [H]
rr = 0.0321;                            % Rotor resistance [Ohm]
lm = 8.738008/wb;                       % Mutual inductance [H]

Machine_parameters = [rs lsl rr lrl lm wb jm np Pn In un b];

if mot_from_on                              
% Motor is started from full speed
    mot_init = [0.01077027 0 0 0 0 0 0 0];
    Initial_conditions = [0 0 0 0 0 0 1 0];
else
% Motor is started from zero speed    
    mot_init = [1 0 0 0 0 0 0 0];
    Initial_conditions = [0 0 0 0 0 0 0 0];
end

Xsl = lsl*wb;                       % Stator reactance [Ohm]
Xrl = lrl*wb;                       % Rotor reactance [Ohm]
Xm = lm*wb;                         % Mutual reactance [Ohm]
Zb = un/In;                         % Base Impedance [Ohm]
Vb = un;                            % Base phase voltage [V]
ib = In;                            % Base phase current [A]
Xb = Zb/wb;                         % Base inductance [H]
rsb = rs/Zb;                        % Stator resistance (p.u.)
rrb = rr/Zb;                        % Rotor resistance (p.u.)
lslb = lsl/Xb;                      % Stator reactance (p.u.)
lrlb = lrl/Xb;                      % Rotor reactance (p.u.)
lmb = lm/Xb;                        % Mutual reactance (p.u.)
Tb = (Pn*np)/wb;                    % Base torque [Nm]
H = (0.5*jm*(wb^2))/(Pn*(np^2));    % Base inertia (p.u.)
M = 1/((1/lm)+(1/lsl)+(1/lrl));     % Mutual flux constant
Mb = M/Xb;
