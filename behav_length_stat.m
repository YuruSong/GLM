function [dwell_time, freq, bin] = behav_length_stat(behav, group, bin_num)
% INPUT:
%   behav: 
%   (courtship behaviors) 1:'chase'	2:'search'	3:'sing' 4:'touch' 5:'stay_close' 6:'reorient' 7:'approach'
%	(non-courtship behaviors) 8:'walk' 9:'still' 10:'water'
%	(all_courtship) 11
%	(non_all_courtship) 12 
%	(other) 13
%   
%   group:
%   1: 'WT_Light_Dark_WT_Light', 
%      'WT_Light_Dark_WT_Dark', 
%   2: 'WT_Or47b_Light_WT_Light', 
%      'WT_Or47b_Light_Or47b_Light', 
%   3: 'WT_Or47b_Dark_WT_Dark', 
%      'WT_Or47b_Dark_Or47b_Dark'
% 
%   bin_num: number of bins in segmenting the length distributions
% 
% OUTPUT:
%   dwell_time: [2, fly_num] cell array
%   freq: [2, fly_num + 1] cell array, '+1' is the average distribution of dwell time
%       about bin, empirically determines max_bin as follows
%           chase: 500 (~16.7 seconds, what a determined fly!)
%           search: 2200 (~73.3 seconds, what a determined fly!)
% Yuru Song, Jan-13-2020

% max bin value
if behav == 1
    max_bin = 400;
    title_str = 'chase';
elseif behav == 2
    max_bin = 2000;
    title_str = 'search';
end
bin = linspace(0, max_bin, bin_num);
% built-in file paths and names
group_path = {
    'WT_Light_Dark',... 
	'WT_Or47b_Light', ...
	 'WT_Or47b_Dark'
    };
group_type = {
    'WT_Light','WT_Dark',...
    'WT_Light','Or47b_Light',...
    'WT','Or47b'
    };
group_type_for_lgd = {
    'WT_Light','WT_Dark',...
    'WT_Light','Or47b_Light',...
    'WT_Dark','Or47b_Dark'
    };

file = ['/Users/yurusong/Documents/StimHMMdata/',group_path{ceil(group)},'/',...
    group_path{ceil(group)},'_Behavior_Prediction.mat']; 
load(file);
fly_group1 = eval([group_type{group*2 -1},'_data']);
num_fly = numel(fly_group1);
dwell_time = cell(2, num_fly);
freq = zeros(2, num_fly + 1, bin_num);
total_dwell_time = [];
for i = 1: num_fly
    behav_seq = (fly_group1{i}(behav,:));
    tmp = (diff([behav_seq,0])==-1).*cumsum(behav_seq);
    tmp = tmp(tmp>0);
    dwell_time{1, i} = diff([0, tmp]);
    total_dwell_time = [total_dwell_time, dwell_time{1, i}];
    freq(1, i, :) = hist( dwell_time{1, i}, bin);
end
freq(1, i+1, :)  = hist(dwell_time{1, i}, bin);
fly_group2 = eval([group_type{group*2},'_data']);
for i = 1: num_fly
    behav_seq = (fly_group2{i}(behav,:));
    tmp = (diff([behav_seq,0])==-1).*cumsum(behav_seq);
    tmp = tmp(tmp>0);
    dwell_time{2, i} = diff([0, tmp]);
    total_dwell_time = [total_dwell_time, dwell_time{2, i}];
    freq(2, i, :)= hist( dwell_time{2, i}, bin);
end
freq(2, i+1, :) = hist(total_dwell_time, bin);


% plot 
h = subplot(3,2,group*2-1 + behav-1);
% plot group 1
options.handle = h;
options.alpha      = 0.5;
        options.line_width = 2;
        options.error      = 'sem';
options.color_area = [128 193 219]./255;% Blue theme
options.color_line = [ 52 148 186]./255;
plot_areaerrorbar(squeeze(freq(1,1:num_fly,:)),options);
hold on;
% plot group 2
options.color_area = [243 169 114]./255;    % Orange theme
options.color_line = [236 112  22]./255;
plot_areaerrorbar(squeeze(freq(2,1:num_fly,:)),options);
xticklabels(cellstr(num2str(xticks'*1200*(bin(2)-bin(1))/36000,'%.2f\n')));
xlabel('behavior time / s');
ylabel('bout count');
lgd1 = group_type_for_lgd{group*2-1};
lgd1(lgd1 == '_') = ' ';
lgd2 = group_type_for_lgd{group*2};
lgd2(lgd2 == '_') = ' ';
legend(['AVE, ',lgd1], ['SEM, ',lgd1],['AVE, ',lgd2], ['SEM, ',lgd2]);
set(gca,'FontSize',12);title(title_str);%ylim([0,300]);