% function myfigure(vargin)

% if isempty(nargin)
    figure;
% elseif nargin == 1
%     nfig = vargin;
%     figure(nfig);
% end;
% builtin('figure')

% routine by BAK to set better default line width and font size

set(gcf,'defaultaxeslinewidth',.5)
set(gcf,'defaultlinelinewidth',.5)
set(gcf,'defaultaxesfontsize',16)
set(gcf,'defaulttextfontsize',16)
% set(gcf,'position',[1 5 1280 701])