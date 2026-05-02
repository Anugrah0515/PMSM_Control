% Sa, Sb, Sc  -> PI switching signals
% Sa_MPC, Sb_MPC, Sc_MPC -> MPC switching signals

% Convert logical to double if needed
clc;
Sa = double(Sa);
Sb = double(Sb);
Sc = double(Sc);

Sa_MPC = double(Sa_MPC);
Sb_MPC = double(Sb_MPC);
Sc_MPC = double(Sc_MPC);

%% Sector number calculation
% Sector = binary combination of Sa Sb Sc
% 000 -> 0
% 001 -> 1
% 010 -> 2
% 011 -> 3
% 100 -> 4
% 101 -> 5
% 110 -> 6
% 111 -> 7

sector_PI  = 4*Sa + 2*Sb + Sc;
sector_MPC = 4*Sa_MPC + 2*Sb_MPC + Sc_MPC;

%% Count occurrences of each sector
count_PI  = histcounts(sector_PI, -0.5:1:7.5);
count_MPC = histcounts(sector_MPC, -0.5:1:7.5);

%% Display results
disp('Sector count for PI:');
for k = 0:7
    fprintf('Sector %d = %d samples\n', k, count_PI(k+1));
end

disp(' ');
disp('Sector count for MPC:');
for k = 0:7
    fprintf('Sector %d = %d samples\n', k, count_MPC(k+1));
end

%% Optional bar plot comparison
figure;
bar([count_PI(:), count_MPC(:)]);
xlabel('Sector Number');
ylabel('Count');
title('Sector Count Comparison');
legend('PI', 'MPC');
xticklabels({'0','1','2','3','4','5','6','7'});
grid on;