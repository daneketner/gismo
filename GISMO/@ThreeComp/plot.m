function plot(TC,varargin)

% WF3_PLOT(TC) Plot three component trace.

% Author: Michael West, Geophysical Institute, Univ. of Alaska Fairbanks
% $Date$
% $Revision$

if numel(TC)>1
    error('Plot must operate on a single element of a ThreeComp object only');
end




figure('Color','w','Position',[50 50 1200 400])

set(gcf,'DefaultAxesFontSize',14);
if length(varargin)>=1
   scale = varargin{1}; 
else 
    scale = 1;
end


% GET SCALE
w = TC.traces;
D = double(w(1:3));
normval = max(max(abs(D)));
D = scale * D./normval;			% do not normalize trace amplitudes
t = get(w(1),'timevector'); 
t = (t-t(1))*86400;
h1 = axes('Position',[.05 .15 .93 .75]);
hold on; box on;
plot(t,D(:,1)+1,'-','Color',[0 0 0.3]);
plot(t,D(:,2)+0,'-','Color',[0.3 0 0]);
plot(t,D(:,3)-1,'-','Color',[0 0.3 0]);
ylim([-1-scale 1+scale]);
xlabel('Time(sec)');
%set(h1,'YGrid','on');
set(h1,'XGrid','on');
%set(h1,'XMinorGrid','on');


% SET TITLE
titlestr = (['Station: ' get(w(1),'station') '      Starting at ' datestr(get(w(1),'start'),'yyyy/mm/dd HH:MM:SS.FFF')]);
if isfield(w(1),'ORIGIN_ORID')
    orid = num2str(get(w(1),'ORIGIN_ORID'));
    titlestr = [titlestr '      orid: ' orid];
else
    title(titlestr,'FontSize',14);
end

% replace dates with station names if stations are different
sta = get(w,'STATION');
chan = get(w,'CHANNEL');
% for i=1:3
%     labels(i) = strcat( sta(i) , '_' , chan(i) );
% end
set( gca , 'YTick' , [-1:1] );
set( gca , 'YTickLabel' , fliplr(chan) );


%PRINT OUT FIGURE
set(gcf, 'paperorientation', 'landscape');
set(gcf, 'paperposition', [.5 2 10 4.5] );
print(gcf, '-depsc2', 'FIG_THREECOMP_PLOT.ps');








