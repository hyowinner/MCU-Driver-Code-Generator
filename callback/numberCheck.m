function numberCheck(hdl, ~, lowerlimit, upperlimit)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function check number value in control in right scope.
% Off cource register value should be an integer.
% If not properal input is input then error msg and return to a setting
% value.
% Hyowinner @2016/7/6
% When as an Edit callback, user may press "OK" button before this function called.
% So hdl will disappear before it is accessed. So error occurs.
% Hyowinner @2016/7/7
% If hex input is got, translate into decical first.
% Hyowinner @2016/7/10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal'; 
inputstr = get(hdl, 'String');
if ~isempty(regexp(inputstr, '0x', 'match'))        % input is hex
    value = hex2dec(strrep(inputstr, '0x', ''));
else
    value = str2double(inputstr);                   % input is dec
end
if ~(round(value) == value)
    msgbox('Input value must be an integer!', CreateStruct);
    set(hdl, 'String', num2str(round(value)));
    return;
end
if value < lowerlimit || value > upperlimit
    msgbox(['Input value must be in the scope: ' num2str(lowerlimit) ' ~ ' num2str(upperlimit) '!'], CreateStruct);
    if isvalid(hdl)
        set(hdl, 'String', num2str(lowerlimit));            % set value only when UI is open
    end
end

end