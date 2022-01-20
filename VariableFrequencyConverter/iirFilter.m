function [y1, y2, y3] = iirFilter(x1, x2, x3, ctrl)
% Infinite impulse response filter

FILTER_FREQUENCY = 100;  %[Hz]

% Filter coefficient
FILT_K = ctrl.deltaControlProcess / ((1/(2*pi*FILTER_FREQUENCY)) + ctrl.deltaMeasurement);

% The persistent variables are retained in memory before calls to the function
persistent y1Prev;
persistent y2Prev;
persistent y3Prev;

% Initialize the persistent variables
if isempty(y1Prev)
    y1Prev = 0;
    y2Prev = 0;
    y3Prev = 0;
end

y1 = (1 - FILT_K) * y1Prev + FILT_K * x1;
y1Prev = y1;

y2 = (1 - FILT_K) * y2Prev + FILT_K * x2;
y2Prev = y2;

y3 = (1 - FILT_K) * y3Prev + FILT_K * x3;
y3Prev = y3;

end