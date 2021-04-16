clear all
close all
clc

%loading and splitting data
cp_data = load('data');
temperature1 = cp_data(1:1600,1);
cp1 =cp_data(1:1600,2);
temperature2 = cp_data(1601:3200,1);
cp2 =cp_data(1601:3200,2);
temperature2 = cp_data(1601:3200,1);
cp2 =cp_data(1601:3200,2);

for i=1:10
%curve fit
[co_eff,S,mu] = polyfit(temperature1,cp1,i);
predicted_cp = polyval(co_eff,temperature1,S,mu);


%Caluclation of parameters for goodness of curve
%sse
for j = 1:length(cp1)
    sse(j) = (cp1(j)-predicted_cp(j))^2;
end
sse_sum(i) = sum(sse);

%r-square
for j = 1:length(cp1)
    ssr(j) = (predicted_cp(j)-(sum(cp1)/length(cp1)))^2;
end
ssr_sum(i) = sum(ssr);
sst(i) = ssr_sum(i)+sse_sum(i);
rsquare(i) = ssr_sum(i)/sst(i);

%adjusted r-square
k = length(co_eff)-1;
adjusted_rsquare(i) = 1-[(1-rsquare(i)^2)*(length(cp1)-1)/(length(cp1)-k-1)];

%rmse
rmse(i) = (sse_sum(i)/length(cp1))^0.5;

%curve fit
[co_eff,S,mu] = polyfit(temperature2,cp2,i);
predicted_cp2 = polyval(co_eff,temperature2,S,mu);


%Caluclation of parameters for goodness of curve
%sse
for j = 1:length(cp2)
    sse2(j) = (cp2(j)-predicted_cp2(j))^2;
end
sse_sum2(i) = sum(sse2);

%r-square
for j = 1:length(cp2)
    ssr2(j) = (predicted_cp2(j)-(sum(cp2)/length(cp2)))^2;
end
ssr_sum2(i) = sum(ssr2);
sst2(i) = ssr_sum2(i)+sse_sum2(i);
rsquare2(i) = ssr_sum2(i)/sst2(i);

%adjusted r-square
k2 = length(co_eff)-1;
adjusted_rsquare2(i) = 1-[(1-rsquare2(i)^2)*(length(cp2)-1)/(length(cp2)-k2-1)];

%rmse
rmse2(i) = (sse_sum2(i)/length(cp2))^0.5;


%compare predicted values with original data
%plot graph
plot(temperature1,cp1,'linewidth',2,'Color','b')
hold on
plot(temperature1,predicted_cp,'LineWidth',2,'color','r')
plot(temperature2,cp2,'linewidth',2,'Color','b')
plot(temperature2,predicted_cp2,'LineWidth',2,'color','g')
hold off
xlabel('Temparature [K]')
ylabel('SpecificData[KJ/Kmol-k]')
legend('originaldata','Curve Fit1')
M(i)=getframe(gcf);
pause(0.3)
end

movie(M,1,1)
videofile = VideoWriter('curve_fitting','Uncompressed AVI');
open(videofile)
writeVideo(videofile,M)
close(videofile)

