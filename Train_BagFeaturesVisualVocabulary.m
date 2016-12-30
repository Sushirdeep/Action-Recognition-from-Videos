% Extract Relevant Features for Training and Testing from the feature set
% obtained when building the Visual Vocabulary
clear; clc; close all;
addpath('3DSIFT\');
addpath('KTH_Data_mat\');
addpath('FeatureFiles\');

load('FeatureFiles\Feature_Descriptors.mat');
% Perform kmeans Clustering to Construct words of the Visual Vocabulary
y_class = y_train(:);


cluster_idx = kmeans(features_set,600, 'Display', 'iter');
m = length(y_class);
signeture = zeros(m,600);
i = 1; n_descriptor = 100;


for k = 1:m
    
    for j = 1:n_descriptor
        
        idx = n_descriptor*(k-1) + j;
        
        signeture(k, cluster_idx(idx))= signeture(k, cluster_idx(idx)) + 1; 
    end
end


save('FeatureFiles\FeaturesBagofVisualVocabulary.mat', 'signeture', 'y_class', 'cluster_idx');