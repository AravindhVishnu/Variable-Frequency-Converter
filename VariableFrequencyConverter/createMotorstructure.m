% --- Create the motor structure ---

motor.motor_name = evalin('caller','motor_name');
motor.un = evalin('caller','un');
motor.in = evalin('caller','in');
motor.In = evalin('caller','In');
motor.fn = evalin('caller','fn');
motor.wb = evalin('caller','wb');
motor.np = evalin('caller','np');
motor.Pn = evalin('caller','Pn');
motor.Vn = evalin('caller','Vn');
motor.jm = evalin('caller','jm');
motor.mot_init = evalin('caller','mot_init');
motor.rs = evalin('caller','rs');
motor.lsl = evalin('caller','lsl');
motor.lrl = evalin('caller','lrl');
motor.rr = evalin('caller','rr');
motor.lm = evalin('caller','lm');
motor.b = evalin('caller','b');
motor.Tl_nom = evalin('caller','Tl_nom');
motor.rpm_nom = evalin('caller','rpm_nom');
motor.w_nom = (2*pi/60)*motor.rpm_nom;
motor.Xsl = evalin('caller','Xsl');
motor.Xrl = evalin('caller','Xrl');
motor.Xm = evalin('caller','Xm');
motor.Zb = evalin('caller','Zb');
motor.Vb = evalin('caller','Vb');
motor.ib = evalin('caller','ib');
motor.Xb = evalin('caller','Xb');
motor.rsb = evalin('caller','rsb');
motor.rrb = evalin('caller','rrb');
motor.lslb = evalin('caller','lslb');
motor.lrlb = evalin('caller','lrlb');
motor.lmb = evalin('caller','lmb');
motor.Tb = evalin('caller','Tb');
motor.H = evalin('caller','H');
motor.M = evalin('caller','M');
motor.Mb = evalin('caller','Mb');

clear motor_name
clear un
clear in
clear In
clear fn
clear wb
clear np
clear Pn
clear Vn
clear jm
clear mot_init
clear rs
clear lsl
clear lrl
clear rr
clear lm
clear b
clear Tl_nom
clear rpm_nom
clear Xsl
clear Xrl
clear Xm
clear Zb
clear Vb
clear ib
clear Xb
clear rsb
clear rrb
clear lslb
clear lrlb
clear lmb
clear Tb
clear H
clear M
clear Mb
