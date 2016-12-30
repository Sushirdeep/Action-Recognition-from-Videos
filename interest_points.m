function [corner_points] = interest_points(video_frames, feature_type)
% Function to Obtain the Interest Points coressponding to Harris corners
% from the video frames
num_frames = length(video_frames(:,:,:,1));
sub_total = [];
for i = 1:15:num_frames
    
    
     if (strcmp(feature_type, 'Harris_Laplace'))
         image_frame = squeeze(video_frames(:,:, i));
         points_feat = detectHarrisFeatures(image_frame); 
         [ ~ , valid_points] = extractFeatures(image_frame, points_feat);
         valid_points = valid_points.selectStrongest(12);
         corners = valid_points.Location ;
         
         pt = round(corners);
     end 
         num_interest_points = length(pt(:,1));     
         if num_interest_points >= 10
         
             sub = pt(1:10, 1:2);
             if i==1
                   sub_total = [sub(:,1), sub(:,2), ones(max(length(sub(:,1))),1)];
             else 
                   sub_total = [sub_total; [sub(:,1), sub(:,2),i*ones(max(length(sub(:,1))),1)]];
             end
         end
     
end
     corner_points = sub_total;
end