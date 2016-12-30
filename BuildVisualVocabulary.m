% Obtain the Feature descriptors coressponding to 3D SIFT by first performing
% initial interest point detection coresponding to the Harris Corners and
clc; 
%clear;
addpath('3DSIFT\'); 
addpath('KTH_Data_mat\');


% Build a Dictionary using Training Data
video_Folder = dir('KTH_Data_mat');
features_set = [];
y_train = [];
vocab_size = 600; feat_type = 'Harris_Laplace';

for file_no = 3:size(video_Folder,1)
    file_Video = video_Folder(file_no).name;
    clear initial_kp; flag =0 ;
    
    load(file_Video);

    video3_dim = uint8(video3_dim);
    initial_kp = interest_points(video3_dim, 'Harris_Laplace'); 
    video3_dim = video3_dim/max(max(max(video3_dim)));
    pix = video3_dim;
    
    if(size(initial_kp,1) < 100)
        continue 
    end    
    % Calculate 3DSIFT descriptors
    % Short demonstration showing how to call 3DSIFT

    offset = 0;
    %tic;
    % Generate descriptors at locations given by subs matrix
    for i=1:100
        
         reRun = 1;
    
         while reRun == 1
        
               loc = initial_kp(i+offset,:);
                
               % Create a 3DSIFT descriptor at the given location
               [keys{i} reRun] = Create_Descriptor(pix,1,1,loc(1),loc(2),loc(3));
        
               if reRun == 1
                   offset = offset + 1;
               end
        
         end
         
         
    end

    for i = 1:100
         feature_Video(i,:) = keys{1,i}.ivec;
    end
    %toc;
    features_set = [ features_set; double(feature_Video)] ;
    
    
    
% Obtaining the Class Labels
     video_name = video_Folder(file_no).name;
     if(strcmp(video_name(1,10:21),'handclapping'))
         y_train = [y_train 1];
     elseif(strcmp(video_name(1,10:15),'boxing'))
         y_train = [y_train 2];
     elseif(strcmp(video_name(1,10:19),'handwaving'))
         y_train = [y_train 3];
     elseif(strcmp(video_name(1,10:16),'running'))
         y_train = [y_train 4];
     elseif(strcmp(video_name(1,10:16),'jogging'))
         y_train = [y_train 5];
     elseif(strcmp(video_name(1,10:16),'walking'))
         y_train = [y_train 6];
     end
    
end


save('FeatureFiles\FeatureDescriptors_Training.mat', 'features_set', 'y_train');
