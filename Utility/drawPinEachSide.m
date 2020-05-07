function pinhdl = drawPinEachSide(mcuview, sidepinnum, pinTotalwidth, pinWidth, pinHight, stpos, mode)
% 此函数为mcuview的某一条边绘制pin脚
% mode: 1表示横着画，2表示竖着画
% 返回pinhdl存储所有pin的句柄
pinhdl = zeros(1,sidepinnum);
switch mode
    case 1
        for ii = 1:sidepinnum
            pinhdl(ii) = uicontrol(mcuview, 'style', 'frame',...
                'Units', 'Normalized',...
                'Position', [stpos(1) + (ii - 1) * pinTotalwidth stpos(2) pinWidth pinHight]);
        end
    case 2
        for ii = 1:sidepinnum
            pinhdl(ii) = uicontrol(mcuview, 'style', 'frame',...
                'Units', 'Normalized',...
                'Position', [stpos(1) (ii - 1) * pinTotalwidth + stpos(2) pinHight pinWidth]);
        end
    otherwise
        error('Not supported draw mode!');
end
end