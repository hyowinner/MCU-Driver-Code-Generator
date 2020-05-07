function verstr = getMATLABver
% Hyowinner @2016/6/28
% return 201xn eg. 2013b. 2015a
vrs = version;
vercell = regexp(vrs, 'R(\d+b)', 'tokens');
verstr = vercell{:};
end