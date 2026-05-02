clc;

%% ===================== LOAD DATA =====================
data = readmatrix('data.csv');

X = data(:,1:end - 1);      % Inputs
y = data(:,end);        % Output class (0–7)

N = size(y,1);

%% ===================== ONE-HOT ENCODING =====================
Y = zeros(N,8);

for i = 1:N
    Y(i, y(i)+1) = 1;   % class 0–7 → index 1–8
end

%% ===================== TRAIN / VALIDATION SPLIT =====================
rng(1);
idx = randperm(N);
nTrain = floor(0.8*N);

Xtrain = X(idx(1:nTrain), :)';
Ytrain = Y(idx(1:nTrain), :)';

Xval   = X(idx(nTrain+1:end), :)';
Yval   = Y(idx(nTrain+1:end), :)';

%% ===================== ANN DEFINITION =====================
net = patternnet([32 16]);

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
fprintf('\nValidation Accuracy: %.2f %%\n', accuracy);

%% ===================== SAVE FOR SIMULINK =====================
save('trained_ann.mat','net');
disp('trained_ann.mat saved successfully');
