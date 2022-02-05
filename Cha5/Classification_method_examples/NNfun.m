function [outputs, net] = NNfun(X,Y)
% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by NPRTOOL
% Created Mon Apr 08 15:39:19 EDT 2013
%
% This script assumes these variables are defined:
%
%   X - input data.
%   Y - target data.

% Copyright 2014 The MathWorks, Inc.

inputs = X';
targets = Y';

% Create a Pattern Recognition Network
hiddenLayerSize = 5;
net = patternnet(hiddenLayerSize);


% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
% net.trainFcn = 'trainbr';
% Hidden the training window
net.trainParam.showWindow = false;
% Making use of parallel computing
[net,~] = train(net,inputs,targets,'useParallel','yes');

% Test the Network
outputs = net(inputs);
% errors = gsubtract(targets,outputs);
% performance = perform(net,targets,outputs)

% View the Network
% view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotconfusion(targets,outputs)
%figure, plotroc(targets,outputs)
%figure, ploterrhist(errors)