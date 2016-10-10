load dc-testbed-raw-and-corr-n=9-N=6;
%load dc-testbed-raw-and-corr-n=7-N=6;

%L = 127;
L = 511;

close all;

start_idx = 1; %400
end_idx = length(corr); % 1200

f = 1000;

time_vector = (0:(end_idx-1)) ./ f;


plot(time_vector, raw(start_idx : end_idx))
title(['Raw ADC data DC testbed, L = ' num2str(L)]);
xlabel('Time (s)');
ylabel('ADC value');



hold on;

for idx = 0:6
   plot([time_vector(1) time_vector(end)],[300*idx 300*idx]); 
end;

%legend('raw data','0 LEDs on', '1 LEDs on', '2 LEDs on', '3 LEDs on', '4 LEDs on', '5 LEDs on', '6 LEDs on');
legend('raw data','0', '1', '2', '3', '4', '5', '6');

yyaxis right;

ylim([0 1800/1024*5/25*1000]);
ylabel('Current (mA)');
hold off;


figure;

plot(time_vector, corr(start_idx : end_idx));
title(['Correlation, L = ' num2str(L)]);
xlabel('Time (s)');
ylabel('Correlation');

hold on;

plot(time_vector, corr_not_included_code(start_idx : end_idx), 'black');

plot([time_vector(1) time_vector(end)],[L/2 L/2], 'red'); 

legend('Corr. w/ present code', 'Corr w/ not present code', 'Threshold');
hold off;


idx_first_tp = 511;%95;
%idx_first_tp = 95;
tp = 0;
fp = 0;
tn = 0;
fn = 0;

f_measure = zeros(1, end_idx);
precision  = zeros(1, end_idx);
recall  = zeros(1, end_idx);


for idx=1:end_idx
   if (mod(idx - idx_first_tp, L) == 0)
        %tp = 0;
        %fp = 0;
        %tn = 0;
        %fn = 0;

       if corr(idx) > L/2
           tp = tp + 1;
       else
           fn = fn + 1;
       end;
   else
       if corr(idx) > L/2
           fp = fp + 1;
       else
           tn = tn + 1;
       end;
   end;
   
   precision(idx) = tp / (tp + fp);
   recall(idx) = tp / (tp + fn);
   
   if (precision(idx) == 0 && recall(idx) == 0)
       f_measure(idx) = 1;
   else
       f_measure(idx) =  2 * precision(idx) * recall(idx) / (precision(idx) + recall(idx));
   end;
       
    
end;


figure;
plot(time_vector, f_measure);
title(['F-Measure, L = ' num2str(L)])
xlabel('Time (s)');
ylabel('F-Measure');

figure;
data = [precision(end) recall(end) f_measure(end)];
bar(data);
set(gca, 'XTickLabel', {'Precision', 'Recall', 'F-measure'});
title('Evaluation Metrics, L = 127'); 



% simpler plot

figure;
end_idx2 = 100;
time_vector2 = (0:end_idx2) .* 1000 ./ f; % in ms
stem(time_vector2, raw(1:end_idx2+1));

title('Raw ADC data DC testbed');
xlabel('Time (ms)');
ylabel('ADC value');

yyaxis right;

ylim([0 1800/1024*5/25*1000]);
ylabel('Current (mA)');







