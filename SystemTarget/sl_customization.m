% ==============================================================================================
%       Hyowinner's Simulink School Cource: Hardware Support Package
%       Development
% ==============================================================================================
%
% Copyright (C) 2016 Hyowinner. All Rights Reserved.
%
% ==========================================================================
%
% History
% Date        Ver   Description
% 2016-6-28  0.1    first version
%
% ==========================================================================

function sl_customization(cm)
% SL_CUSTOMIZATION for Hyo Customization:...

cm.registerTargetInfo(@loc_register_device);
end

 

% loc_register_devie resigters self defined device into Simulink Parameter
% cofiguration
function thisprod = loc_register_device
  thisprod = RTW.HWDeviceRegistry;
  thisprod.Vendor = 'CYPRESS';
  thisprod.Type = 'ARM Cortex-R5';
  thisprod.Alias = {};
  thisprod.Platform = {'Prod', 'Target'};
  thisprod.setWordSizes([8 16 32 32 32]);
  thisprod.LargestAtomicInteger = 'Int';
  thisprod.LargestAtomicFloat = 'Float';
  thisprod.Endianess = 'Little';
  thisprod.IntDivRoundTo = 'Zero';
  thisprod.ShiftRightIntArith = true;
  thisprod.setEnabled({'LargestAtomicInteger','LargestAtomicFloat'});
end