% SVM Mulitclass Classification for Action Recogntion 
% This performs SVM Multiclass  Classification using one vs one methodology
%For each binary learner, one class is positive, another is negative, and 
%the software ignores the rest. This design exhausts all combinations of class pair assignments.
clear; clc;
addpath('FeatureFiles\');


%% Performing Action Recognition on the Bag of Features Model  using Multiclass SVM
% Loading the Bag of Features Model

load('FeatureFiles\FeaturesBagofVisualVocabulary.mat');
m = size(y_class, 1);
% Shuffle the training set
indxs = randperm(length(y_class));
C_values = [0.01; 0.1; 1; 10; 100; 1000];

for i = 1:length(C_values)
    % Performing 5 fold cross vaalidation
     C = C_values(i,:);
     featureBag_combn = signeture(indxs(1:m), :);
     action_labels = y_class(indxs(1:m), :);
     t = templateSVM('Standardize',1,'KernelFunction','linear', 'BoxConstraint', C);      
     
     SVMMulticlass_combn = fitcecoc(featureBag_combn, action_labels, 'Coding', 'onevsone',...
                                          'Learners', t); 
     ActionCrossVal = crossval(SVMMulticlass_combn, 'KFold', 5);
     
     
     cross_val_error(i,:) = kfoldLoss(ActionCrossVal);
end

[min_cvError, indC] = min(cross_val_error);
C_opt = C_values(indC,:);



train_idx = round(0.80*size(y_class, 1));
% Performing Training on 80% of the dataset and Testing on 20% of the
% dataset

featureBag_train = signeture(indxs(1:train_idx), :);
class_train = y_class(indxs(1:train_idx), :);
t = templateSVM('Standardize',1,'KernelFunction','linear', 'BoxConstraint', C_opt);

SVMMulticlass_action = fitcecoc(featureBag_train, class_train, 'Coding', 'onevsone',...
                                    'Learners',t); 
% Computing Training Error
predict_train = predict(SVMMulticlass_action, featureBag_train);
Conftrain_mat = confusionmat(class_train, predict_train);
train_error = eval_mcr(class_train, predict_train);

% Computing Testing Error
target_action = y_class(indxs((train_idx+1): m), :);
featureBag_test = signeture(indxs((train_idx+1): m), :);
predict_action = predict(SVMMulticlass_action, featureBag_test);

test_error = eval_mcr(target_action, predict_action);
Conftest_mat = confusionmat(target_action, predict_action);


fprintf('The test accuracy obtained = %f\n', test_error);