% Playing a video file from the KTH Video dataset in Matlab
clear; clc; close all;

addpath('VideoDataset_KTH');
VideosFolder ='Action_Recognition_from_Videos\VideoDataset_KTH\'; 
VideoFiles = dir(VideosFolder);


FileNo = 12;
Videofile_name = VideoFiles(FileNo).name;
% Construct a VideoReader object associated with the video file
KTH_videoFile = strcat(VideosFolder,Videofile_name); 
vidObj = VideoReader(KTH_videoFile);
%Determine the height and width of the frames
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;
% Create a movie structure
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
% Read one frame at a time using readFrame until the end of the file is reached
% Append data from each video frame to the structure array
k = 1;
while hasFrame(vidObj)
    s(k).cdata = readFrame(vidObj);
    k = k+1;
end
%Get information about the movie structure array, s.
whos s
% Display the 1st frame stored in s
image(s(1).cdata)
% Resize the current figure and axes based on the video's width and height
% Then, play the movie once at the video's frame rate using the movie function
set(gcf,'position',[150 150 vidObj.Width vidObj.Height]);
set(gca,'units','pixels');
set(gca,'position',[0 0 vidObj.Width vidObj.Height]);
movie(s,1,vidObj.FrameRate);
% Close the figure
close;
