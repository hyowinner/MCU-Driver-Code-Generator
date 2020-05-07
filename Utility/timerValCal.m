function retval = timerValCal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This functino calculate the count value for Sub Clock Timer according to 
% current Fixed Step-size.
% Support StepSize scope: [30.52e-5 30.0019]s
% Hyowinner @ 2016/09/06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stepsize = str2double(get_param(gcs, 'FixedStep'));         % can not recognize expression such as 5*30.52e-6 and make it Nan.
if isnan(stepsize)
    stepsize = eval(get_param(gcs, 'FixedStep'));           % Check when Nan if its source is a expression such as 5*30.52e-6.
    if isnan(stepsize)
        error('[rtOneStep Period Calculation Error:] Fixed Step Size is not valid in Configuration Parameters!');
    end
end
temp_div = 1;       % temp prescale factor
val = stepsize/(30.52*1e-6 * temp_div);
while val > 2^16 - 1
   temp_div = temp_div + 1;
   if temp_div > 2^4 - 1
       error(['[rtOneStep Period Calculation Error:] Can not find proper count value to adapt step-size of ' num2str(stepsize) 's.']);
   end
   val = stepsize/(30.52*1e-6 * temp_div);
end
div = temp_div;     % final prescale factor
if ~isequal(val, round(val))
    val = round(val);
    if val <= 0
        error(['[rtOneStep Period Calculation Error:] Can not find proper count value to adapt step-size of ' num2str(stepsize) 's.']);
    else
        warning('[rtOneStep Period Calculation Warning:] There may be a bit gap between Simulation Step and rtOneStep cycle!');
    end
end
retval = [val div];   % combine to only one return value is easy for tlc calling.