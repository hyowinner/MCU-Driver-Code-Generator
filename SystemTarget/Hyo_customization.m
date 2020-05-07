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
% 2016-6-28   0.1    first version
%
% ==========================================================================

function Hyo_customization()
% Define the replacement data type and assign its headerfile
% This file will be called:
% choosing Hyo.tlc
% opening a model which has configured Hyo.tlc
% running post_PCG

alias_table = {'uint_io32_t','uint32';
    'uint_io16_t','uint16';
    'uint_io8_t','uint8';
    };

for ii = 1:length(alias_table)
    alias2base(alias_table{ii,1},alias_table{ii,2},'s6j3200io_basetypes.h');
end

end

function alias2base(object_name,base_type,hfile_name)
% This function check whether base_type exists in base wkspace.
% If not, create it.
% object_name: name of base type alias object
% base_type: int8,uint32,double, single etc.
% hfile_name: C header file which defines there alias
if ~(evalin('base', ['exist(', [char(39),object_name,char(39)] ,')']))
    var_name = object_name;  %save a name or it will become a struct 
    object_name = Simulink.AliasType;
    object_name.BaseType = base_type;
    object_name.HeaderFile = hfile_name;
    object_name.DataScope = 'Imported';
    assignin('base', var_name, object_name);
end
end