close all;clc;clear all;
figure(1);
set(gcf,'Units','Normalized','OuterPosition',[0,0,.5,.8]);
for group = 1: 3
    for behav = 1: 2
        [dwell_time, freq] = behav_length_stat(behav, group, 30);
    end
end
