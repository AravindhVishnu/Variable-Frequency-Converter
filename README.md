# Variable-Frequency-Converter
Matlab/Simulink model of a Variable Frequency Converter

Background:
One of my professional interests is the variable frequency converter because 
of the way it is able to control the speed and torque of an electrical motor.
Matlab/Simulink is a great simulation tool for building the plant and controller.

Description:
In this model, the plant consists of the three-phase power grid, power electronics part
of the variable frequency controller and the electrical motor and load. The controller
represents the embedded SW that is mainly responsible for sending the PWM on/off signals
to the insulated gate bipolar transistors (IGBT). The power electronics module consists
of the voltage source converter topology, since it is the most common. The controller
block implements the simplest form of converter control function which is the open loop
V/Hz ramp. The PWM modulation technique can be either Sine, Saddle or Space Vector.
The controller block consists of the control process block and the PWM driver block.
Control process contains the algorithms and logic which executes cyclically once every
25us (40kHz) and calculates timer compare values (ccr values). The ccr values are used
as inputs to the PWM driver block which is more or less an advanced control timer capable
of generating six PWM outputs (this is similar to the timer type which is part of the
STM32 family of microcontrollers). All interesting electrical and mechanical signals are
collected and can be viewed in the Measurements block.

Tools:
Matlab/Simulink 2021b, Simscape Electrical (formerly SimPowerSystems)

Instructions:
The model parameters are located in the init.m script file. Open it and optionally set
the simulation time, start/stop ramp time, PWM modulation technique, PWM carrier frequency,
rotation direction, load type, etc. Afterwards, run the init.m script. Then open the 
variableFrequencyConverter.slx Simulink model and run it.
