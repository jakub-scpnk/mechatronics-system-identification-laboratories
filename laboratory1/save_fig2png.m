function err = save_fig2png(h, size, filename)
%
%   function  
%       err = save_fig2png(h, size, filename) 
%       
%   saves figure pointed by h to filename.png.
%   the function sets font size to 12
%   h        - pointer to figure being saved 
%   size     - [width height] - size of the resulting image in cm.
%   filename - isn't it obvious? 
% 
%   EXAMPLE: 
%   save_fig2png(gcf,[16 9], 'test'); 
%
%   code by L. Ambrozinski ambrozin@agh.edu.pl 
%
err = 0;

res = '-r300'; 
set(h,'PaperUnits','centimeters','PaperPosition',[0 0 size(1) size(2)])

allAxesInFigure = findall(h,'type','axes');
allAxes = findall(0,'type','axes');

for i = 1:length(allAxes)
    set(allAxes(1),'fontsize',12, 'box', 'off' )
end

 print(h,'-dpng','-opengl',res,filename)