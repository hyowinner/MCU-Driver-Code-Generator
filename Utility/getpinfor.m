function portpin = getpinfor(resname, pinfunc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function get pin name in pinfunc for resource.
% eg. resname -- AN0(AL0)
% eg. pinfunc -- get_pin_func(208)
% if not found then return empty, found then return Px_xx.
% Hyowinner @2016/7/7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
portpin = {};
for ii = 1:length(pinfunc)
   if ~isempty(strfind(pinfunc(ii), resname))
       portpin{end + 1} = cell2mat(regexp(pinfunc(ii), 'P\d_\d{2}', 'match'));
   end
end