close all;
clear all;

load ac_data;

e = 300;

f = 10000;

L = 127;

time_vector = (0:(e-1)) ./f .* 1000;

%[ax,h1,h2] = plotyy(time_vector, raw_ac_adc(1:e), time_vector, trigger(1:e));

figure;
plot(time_vector, raw_ac_adc(1:e));


hold on; 
%plot([1 e],[mean(raw_ac_adc) mean(raw_ac_adc)], 'cyan');
title('Incoming data');
ylabel('Raw ADC Values');
xlabel('Time (ms)');


yyaxis right;
plot(time_vector, trigger(1:e));
ylabel('Trigger Ouput');
ylim([-.1 1.1]);

%set(get(ax(1),'Ylabel'),'String','Raw ADC Value') 
%set(get(ax(2),'Ylabel'),'String','Triggering Output') 

%legend('Raw ADC Values', 'Mean ADC Values', 'Trigger Circuit Output');
legend('Raw ADC Values', 'Trigger Output');


new_idx = 1;

for idx=1:length(raw_ac_adc)
    if (trigger(idx) == 0)
        adc_dsp(new_idx) = raw_ac_adc(idx);
        new_idx = new_idx + 1;
    end;
end;


adc_dsp = abs(adc_dsp - mean(adc_dsp));

figure;
plot(time_vector, adc_dsp(1:e) .* 4 ./ 4095 ./ 2.8 .* 1000);
title('Processed ADC Values');
xlabel('Time (ms)');
%ylabel('Scaled ADC Values');
ylabel('Current (mA)');

figure;
hold on;
plot(time_vector, corr(1:e) ./ L);
plot(time_vector, corr_not_included_code(1:e) ./ L);
plot([time_vector(1) time_vector(end)],[1/2 1/2]);

title('Identifying LED');
xlabel('Time (ms)');
ylabel('Code similarity');
legend('Similarity w/ present code', 'Similarity w/ not present code', 'Threshold');

hold off;
