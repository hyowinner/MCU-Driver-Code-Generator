function hdl = plotCircle(xpos, ypos, radius)
% �˺�����ĳ��fig�ϻ���һ���뾶Ϊradius��Բ��
% ������[xpos, ypos]��λ����
ax = axes('position',[xpos ypos radius radius],...
    'layer','top'); 
theta = 0:0.1:2*pi;
hdl = plot(ax,cos(theta) * radius,sin(theta) * radius,'k');
axis off;
axis equal;
end