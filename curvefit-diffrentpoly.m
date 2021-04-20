clear all
close all
clc

%prepocessing data
cp_data = load('data');
temperature = cp_data(:,1);
cp =cp_data(:,2);
for i=1:10
%curve fit
[co_eff,S,mu] = polyfit(temperature,cp,i);
predicted_cp = polyval(co_eff,temperature,S,mu);


%Caluclation of parameters for goodness of curve
%sse
for j = 1:length(cp)
    sse(j) = (cp(j)-predicted_cp(j))^2;
end
sse_sum(i) = sum(sse);

%r-square
for j = 1:length(cp)
    ssr(j) = (predicted_cp(j)-(sum(cp)/length(cp)))^2;
end
ssr_sum(i) = sum(ssr);
sst(i) = ssr_sum(i)+sse_sum(i);
rsquare(i) = ssr_sum(i)/sst(i);

%adjusted r-square
k = length(co_eff)-1;
adjusted_rsquare(i) = 1-[(1-rsquare(i)^2)*(length(cp)-1)/(length(cp)-k-1)];

%rmse
rmse(i) = (sse_sum(i)/length(cp))^0.5;

%compare predicted values with original data
%plot graph
plot(temperature,cp,'linewidth',2,'Color','b')
hold on
plot(temperature,predicted_cp,'LineWidth',2,'color','r')
hold off
xlabel('Temparature [K]')
ylabel('SpecificData[KJ/Kmol-k]')
legend('originaldata','Curve Fit1')
M(i)=getframe(gcf);
pause(0.3)
end

movie(M,1,10)
videofile = VideoWriter('curve_fitting4','Uncompressed AVI');
open(videofile)
writeVideo(videofile,M)
close(videofile)

