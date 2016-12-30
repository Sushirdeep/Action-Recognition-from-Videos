function loss = eval_mcr(targets,predictions)
% Evaluate the mis-classification rate loss
% Loss = eval_mcr(Targets, Predictions)
%
% In:
%   Predictions : vector of predictions made by the classifier
%
%   Targets : vector of true labels (-1 / +1)
%
% Out:
%   Loss : mis-classification rate

% calculate mis-classification rate 
% #test_trials
test_trials = length(targets);
misclassified_trials= zeros(test_trials,1);
for i=1:length(targets)
    if(predictions(i) ~= targets(i))
        misclassified_trials(i,:) = 1;
    end
end
loss = sum(misclassified_trials)/ test_trials ;