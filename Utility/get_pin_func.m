function pinfunc = get_pin_func(cur_model)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function create corresponding pinfunc Map with pininfo in txt according to 
% current MCU type selected in the model.
% Hyowinner @2016/7/7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
systarget = get_param(cur_model, 'SystemTargetFile');
assert(strcmp(systarget, 'Hyo.tlc'), 'Please select Hyo.tlc as System Target File in Configuration Parameters!');
mcutype = get_param(cur_model, 't_mcutype');
type = mcutype(end);
switch type
    case 'K'
        pinnum = 208;
    case 'L'
        pinnum = 216;
    case 'M'
        pinnum = 256;
    otherwise
        error('Error: Not support Pin number!');
end
assert(pinnum > 0 && round(pinnum) == pinnum, 'Pin number should be a positive integer!');
keySet = [1:pinnum];
valueSet = importdata(['pin' num2str(pinnum) '.txt']);
pinfunc = containers.Map(keySet,valueSet);
