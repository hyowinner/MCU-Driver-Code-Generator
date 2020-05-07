function within_pin(src, ~, pinhdl, infrm)
% When mouse is in a pin, set pin green
if exist('pinfo', 'var')
    detele(pinfo);
end
persistent pinn
if isempty(pinn)
    pinn = '';  % have to initialize
end
cp = src.CurrentPoint;  % get pixel position
figpos = get(src, 'Position');
figsize = figpos(1, 3:4);
xinit = cp(1,1)/figsize(1);
yinit = cp(1,2)/figsize(2);  %normalized pixel
for ii = 1:length(pinhdl)
    pin_loc = get(pinhdl(ii), 'Position');
    if (xinit > pin_loc(1)&& xinit < pin_loc(1) + pin_loc(3)&&...
            yinit > pin_loc(2)&& yinit < pin_loc(2) + pin_loc(4))
        set(pinhdl(ii), 'BackgroundColor', 'green');
        pinn = ii;
        break;
    else
        set(pinhdl(ii), 'BackgroundColor', ones(1,3) * 0.94);
    end
end
pininfo = get_pin_func(gcs);
pinfo = uicontrol(infrm, 'Style', 'text',...
    'Units', 'Normalized',...
    'Position', [0.1 0.6 0.8 0.2],...
    'string',  pininfo(pinn));
end