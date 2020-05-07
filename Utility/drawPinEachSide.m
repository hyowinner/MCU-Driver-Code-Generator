function pinhdl = drawPinEachSide(mcuview, sidepinnum, pinTotalwidth, pinWidth, pinHight, stpos, mode)
% �˺���Ϊmcuview��ĳһ���߻���pin��
% mode: 1��ʾ���Ż���2��ʾ���Ż�
% ����pinhdl�洢����pin�ľ��
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