% load the OI SST data, compare timeseries, correlation grid. 

close all
clear all

basedir = '/Users/gdm2v07/Dropbox/Papers/Dennehy-et-al-2019/';

[mon,year,HH_A,	HH_B,	HH_F,	HH_E,	HH_D,	HH_C,	LL_C,	LL_B,	LL_D,	LL_A]=...
    textread([basedir 'formatted_sst_data_renamed.csv'],'%s%d%f%f%f%f%f%f%f%f%f%f','delimiter',',','headerlines',3);

year(year > 20) = year (year > 20) + 1900;
year(year < 1900) = year (year < 1900) + 2000;
mjg = year + nan;
for k = 1: length(mjg),mjg(k) = datenum(['15-',mon{k},'-',num2str(year(k))]);end

data = [HH_A	HH_B	HH_C	HH_D	HH_E	HH_F	LL_A	LL_B	LL_C	LL_D];
offset = 0:9;

labels = {'HH_A',	'HH_B',	'HH_C',	'HH_D',	'HH_E',	'HH_F',	'LL_A',	'LL_B',	'LL_C',	'LL_D'};

%
% interject a correlation map 

mythinfigure; 
set(gcf,'position',[1   49 812 617])

sz = size(data);
ns = sz(2);

CC = ones(ns) + nan;
CP = CC;
% clear CC CP
for i = 1:ns
    for j = 1:i
        A = data(:,i);
        B = data(:,j);
        A = detrend(data(:,i));
        B = detrend(data(:,j));
       
        [Cf,p] = corrcoef(A,B);
        CC(i,j) = Cf(2,1);
        CP(i,j) = p(2,1);
        clear A B k1 k2
        
    end
end

% subplot(311)
% pcolor(CC)
imagesc(CC)
xlabel('Site no.','fontsize',20)
ylabel('Site no.','fontsize',20)
% caxis([min(R) max(R)])
% cb = colorbar('ytick',[R]);
colorbar
caxis([0.5 1])
axis square
shading flat
colormap(flipud(hot(10)))
title('Correlation between locations')
set(gca,'xticklabel',labels)
set(gca,'yticklabel',labels)

%
hold on;
 set(gcf,'paperpositionmode','auto')
print('-dpng',[basedir '/sst_timeseries_correlation_v2.png'])

cm=makeColorMap([1,0,0],[1,1,1],[0,0,1],15);
cm=cm([1:6 12:15],:);

cm=lines(10);

%%
mythinfigure; hold on; box on; set(gcf,'position',[726   101   651   566])
% plot(mjg,data+offset,'color',[cm(1:6,:); cm(end-4:end,:)]');
l = [5 6 10 9 4 3 8 7 2 1];

for k=1:10,plot(mjg,data(:,l(k))-offset(k),'color',cm(k,:)); end
xlim([min(mjg) max(mjg)]);
datetick('x','keeplimits');
legend(labels(l),'location','eastoutside')
xlabel('Year'), ylabel('SST [ºC offset]')

 set(gcf,'paperpositionmode','auto')
print('-dpng',[basedir '/sst_timeseries_v2.png'])
print('-dsvg',[basedir '/sst_timeseries_v2.svg'])
