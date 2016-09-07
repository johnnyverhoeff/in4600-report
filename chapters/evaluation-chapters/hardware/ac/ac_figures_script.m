close all;
clear all;

load ac_data;

e = 300;

[ax,h1,h2] = plotyy(1:e, raw_ac_adc(1:e), 1:e, trigger(1:e));
hold on; 
plot([1 e],[mean(raw_ac_adc) mean(raw_ac_adc)], 'cyan');
title('Incoming data');
xlabel('Sample');

set(get(ax(1),'Ylabel'),'String','Raw ADC Value') 
set(get(ax(2),'Ylabel'),'String','Triggering Circuit Output') 

legend('Raw ADC Values', 'Mean ADC Values', 'Trigger Circuit Output');


new_idx = 1;

for idx=1:length(raw_ac_adc)
    if (trigger(idx) == 0)
        adc_dsp(new_idx) = raw_ac_adc(idx);
        new_idx = new_idx + 1;
    end;
end;


adc_dsp = abs(adc_dsp - mean(adc_dsp));

figure;
plot(adc_dsp(1:e));
title('Processed ADC Values');
xlabel('Sample');
ylabel('Scaled ADC Values');

figure;
hold on;
plot(corr(1:e));
plot(corr_not_included_code(1:e));
plot([1 e],[127/2 127/2]);

title('Correlation');
xlabel('Sample');
ylabel('Correlation number');
legend('Corr. w/ present code', 'Corr. w/ not present code', 'Threshold');

hold off;
