clc; 
%% ===================== LOAD DATA =====================
data = readmatrix('data.csv');

Xfull = data(:,1:7);      % Inputs
yfull = data(:,8);        % Output class (0–7)

%% ===================== PARAMETERS =====================
sampling_list = [1 2 3 4 5 8 10 15 20 50 100 250 500 750 1000];
num_tests = length(sampling_list);

accuracy_results = zeros(num_tests,1);

%% ===================== LOOP OVER SAMPLING RATES =====================

for s = 1:num_tests
    
    sampling = sampling_list(s);
    fprintf('\n========== Sampling Rate = %d ==========\n', sampling);
    
    % Downsample dataset
    X = Xfull(1:sampling:end,:);
    y = yfull(1:sampling:end);
    
    N = size(X,1);

    % Skip if too few samples
    if N < 20
        fprintf('Too few samples. Skipping...\n');
        accuracy_results(s) = NaN;
        continue;
    end
    
    %% ===================== NORMALIZATION =====================
    [Xn, mu, sigma] = zscore(X);
    
    %% ===================== ONE HOT ENCODING =====================
    Y = zeros(N,8);
    for i = 1:N
        Y(i, y(i)+1) = 1;
    end
    
    %% ===================== TRAIN / VALIDATION SPLIT =====================
    rng(1);
    idx = randperm(N);
    nTrain = floor(0.8*N);

    Xtrain = Xn(idx(1:nTrain), :)';
    Ytrain = Y(idx(1:nTrain), :)';

    Xval   = Xn(idx(nTrain+1:end), :)';
    Yval   = Y(idx(nTrain+1:end), :)';

    %% ===================== ANN DEFINITION =====================
    net = patternnet([16 8]);

    net.performFcn = 'crossentropy';
    net.trainFcn   = 'trainscg';
    net.divideFcn  = 'divideind';

    net.divideParam.trainInd = 1:size(Xtrain,2);
    net.divideParam.valInd   = [];
    net.divideParam.testInd  = [];

    net.layers{1}.transferFcn = 'poslin';
    net.layers{2}.transferFcn = 'poslin';
    net.layers{3}.transferFcn = 'softmax';

    %% ===================== TRAIN ANN =====================
    net = train(net, Xtrain, Ytrain);

    %% ===================== VALIDATION ACCURACY =====================
    Ypred = net(Xval);

    [~, predClass] = max(Ypred, [], 1);
    [~, trueClass] = max(Yval, [], 1);

    accuracy = mean(predClass == trueClass) * 100;
    accuracy_results(s) = accuracy;

    fprintf('Validation Accuracy: %.2f %%\n', accuracy);

    %% ===================== SAVE MODEL =====================
    model_name = sprintf('trained_ann_sampling_%d.mat', sampling);
    save(model_name, 'net', 'mu', 'sigma', 'sampling', 'accuracy');
    
end

%% ===================== RESULTS TABLE =====================
Results = table(sampling_list', accuracy_results, ...
    'VariableNames', {'SamplingRate','AccuracyPercent'});

disp(Results);

%% ===================== PLOT =====================
figure;
plot(sampling_list, accuracy_results, '-o','LineWidth',2);
grid on;
xlabel('Sampling Rate');
ylabel('Validation Accuracy (%)');
title('Sampling Rate vs ANN Accuracy');

%% ===================== SAVE RESULTS =====================
writetable(Results,'sampling_vs_accuracy.csv');

%% ===================== SAVE BEST MODEL INFO =====================
[best_acc, best_idx] = max(accuracy_results);
best_sampling = sampling_list(best_idx);

fprintf('\nBest Sampling Rate: %d\n', best_sampling);
fprintf('Best Accuracy: %.2f %%\n', best_acc);

disp('Experiment completed successfully.');