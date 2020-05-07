function hdl = plotCircle(xpos, ypos, radius)
% 此函数在某个fig上绘制一个半径为radius的圆形
% 安放在[xpos, ypos]的位置上
ax = axes('position',[xpos ypos radius radius],...
    'layer','top'); 
theta = 0:0.1:2*pi;
hdl = plot(ax,cos(theta) * radius,sin(theta) * radius,'k');
axis off;
axis equal;
end