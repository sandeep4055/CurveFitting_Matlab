clear all
close all
clc

%prepocessing data
cp_data = load('data');
temperature = cp_data(:,1);
cp =cp_data(:,2);

%curve fit
co_eff1 = polyfit(temperature,cp,1);
co_eff2 = polyfit(temperature,cp,3);

%predicting cp using co_eff
predicted_cp1 = polyval(co_eff1,temperature);
predicted_cp2 = polyval(co_eff2,temperature);

%Caluclation of parameters for goodness of curve
%sse
for i = 1:length(cp)
    sse1(i) = (cp(i)-predicted_cp1(i))^2;
    sse2(i) = (cp(i)-predicted_cp2(i))^2; 
end
sse1_sum = sum(sse1)
sse2_sum = sum(sse2)

%r-square
for i = 1:length(cp)
    ssr1(i) = (predicted_cp1(i)-(sum(cp)/length(cp)))^2;
    ssr2(i) = (predicted_cp2(i)-(sum(cp)/length(cp)))^2; 
end

ssr1_sum = sum(ssr1);
ssr2_sum = sum(ssr2);

sst1 = ssr1_sum+sse1_sum;
sst2 = ssr2_sum+sse2_sum;

rsquare_1 = ssr1_sum/sst1
rsquare_2 = ssr2_sum/sst2

%adjusted r-square
k1 = length(co_eff1)-1;
k2 = length(co_eff2)-1;

adjusted_rsquare_1 = 1-[(1-rsquare_1^2)*(length(cp)-1)/(length(cp)-k1-1)]
adjusted_rsquare_2 = 1-[(1-rsquare_2^2)*(length(cp)-1)/(length(cp)-k2-1)]

%rmse
rmse1 = (sse1_sum/length(cp))^0.5
rmse2 = (sse2_sum/length(cp))^0.5

%compare predicted values with original data
%plot graph
plot(temperature,cp,'linewidth',2,'Color','b')
hold on
plot(temperature,predicted_cp1,'LineWidth',2,'color','r')
plot(temperature,predicted_cp2,'LineWidth',2,'color','y')
xlabel('Temparature [K]')
ylabel('SpecificData[KJ/Kmol-k]')
legend('originaldata','Curve Fit1','Curve Fit2')

