function val = get_param_periname(blockhandle)
% This function get value of periname from g_pv of PSL block
% Hyowinner @2016/6/27
% Using a simple way to get periname @2016/7/6
pvstr = get_param(blockhandle, 'g_pv');
res = regexp(pvstr, '[,;]', 'split');
val = res{2};
end