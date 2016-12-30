
% Final Project
% Video Dataset files from KTH Human Action Dataset
clear; clc; close all;
addpath('VideoDataset_KTH');
addpath('KTH_Data_mat');

VideosFolder ='Action_Recognition_from_Videos\VideoDataset_KTH\'; 
VideoFiles = dir(VideosFolder);


for FileNo = 3:size(VideoFiles, 1)
    
     Videofile_name = VideoFiles(FileNo).name;
     % Construct a VideoReader object associated with the video file
     KTH_videoFile = strcat(VideosFolder,Videofile_name); 
     
     vidObj = VideoReader(KTH_videoFile);
     %Determine the height and width of the frames
     vidHeight = vidObj.Height;
     vidWidth = vidObj.Width;
     vidFrames = vidObj.NumberOfFrames;
     % Create a video as a 3 dimensional data
     video3_dim = zeros(vidHeight, vidWidth, vidFrames);
     % Read one frame at a time using readFrame until the end of the file is reached
     % Append data from each video frame to the structure array
     for k = 1: vidFrames
          vid_image = read(vidObj, k);
          vid_image = rgb2gray(vid_image);
          video3_dim(:, :, k) = vid_image ;
     end

     % Save the video file as a mat file
     
     [pathstr, File_name, ext] = fileparts(KTH_videoFile);
      File_out = strcat('KTH_Data_mat\', File_name, '.mat');


      save(File_out,'video3_dim');


end

