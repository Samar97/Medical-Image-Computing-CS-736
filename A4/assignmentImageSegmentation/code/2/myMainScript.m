%% MyMainScript
clc;
close all;
clear;
% warning('off','all');

% Setting the color scale %
my_num_of_colors = 256;
col_scale =  [0:1/(my_num_of_colors-1):1]';
my_color_scale = [col_scale,col_scale,col_scale];

% Set to_save to 1, if you want to save the generated pictures %
to_save  = 1;
is_color = 1;

% Loading and displaying the data %
original_data = load('../../data/assignmentSegmentBrainGmmEmMrf.mat');
brain_image   = original_data.imageData;
brain_mask    = original_data.imageMask;
old_brain_image = brain_image;

% savefig(my_color_scale,brain_image,"Original Brain MRI","Original_Brain_Image.png",0,to_save);
% savefig(my_color_scale,brain_mask,"Brain Mask","Brain_Mask.png",0,to_save);

brain_image = brain_image .* brain_mask;
% savefig(my_color_scale,brain_image,"Brain Image after applying mask","Masked_Brain.png",0,to_save);
[h, w, num_chan] = size(brain_image);

tic;

%% Initialisation of parameters
K = 3;
Beta = 0.7;
class_means = zeros(K,1);
class_stds = zeros(K,1);
membership = zeros(h,w,K);
X = ones(h,w);
num_iter = 100;

% We use K+1 classes as the background is to be considered as a separate class in addition to the 3 we want to find
[label, C] = kmeans(brain_image(:),K+1);
label = reshape(label, h,w);
X = label;
[C, idx] = sort(C);
for k=1:K+1
	X(label == idx(k)) = k-1;
end

X (brain_mask==1 & X == 0) = 1;

for k=1:K
	points_k = X==k;
	class_means(k) = mean(brain_image(points_k));
	class_stds(k)  = std(brain_image(points_k));
end

%% Part a
fprintf('Chosen Value of beta = %f \n',Beta);

%% Part b
% We choose K Means algorithm to initialise the labels as Kmeans performs hard assignment
% Motivation :	We use the labels of K Means which is hard label assignment as the algorithm
%				is analytical and is a good starting model.
savefig(my_color_scale,X,"Initial Label Image X","Initial_Label_Image.png",0,to_save);

%% Part c
% We choose K Means algorithm to initialise the means
% Motivation : We use the sample means and standard deviation of the labels 
% as they are the ML estimate for the class means given the labels (which were initialised as above)

fprintf('The initial class means : \n');
disp(class_means);

fprintf('The initial class stds : \n');
disp(class_stds);

%% Part d
%% Running modified EM
for iter = 1:num_iter
	
	% Finding membership in E step
	membership = myEStep(X, brain_image, K, Beta, brain_mask, class_means, class_stds, true);
	
	% Finding means and stds in M step
	[class_means, class_stds] = myMStep(K, membership, brain_image, class_means, brain_mask);
	
end

%% Part e

%% Calculating Results
[class_means, sorted_idx] = sort(class_means);
membership_old = membership;
membership(:,:,1) = membership_old(:,:,sorted_idx(1));
membership(:,:,2) = membership_old(:,:,sorted_idx(3));
membership(:,:,3) = membership_old(:,:,sorted_idx(2));

% for k = 1:K
% 	membership(:,:,k) = membership_old(:,:,sorted_idx(k));
% end

% bias_removed_image = zeros(h, w);
% for k = 1:K
% 	ck = class_means(k);
% 	bias_removed_image = bias_removed_image + ck * membership(:,:,k);
% end
% residual_image = brain_image - bias_removed_image.*bias;



%% Part f
% savefig(my_color_scale,old_brain_image,"Original Brain MRI","Original_Brain_Image.png",0,to_save);
% savefig(my_color_scale,brain_mask,"Brain Mask","Brain_Mask.png",0,to_save);
% savefig(my_color_scale,brain_image,"Brain Image after applying mask","Masked_Brain.png",0,to_save);

% for k = 1:K
% 	savefig(my_color_scale,membership(:,:,k),strcat("Optimal Membership for k = ",num2str(k)),strcat("Optimal_Membership_k_",num2str(k),".png"),0,to_save);
% end

% savefig(my_color_scale,bias,"Bias Field","Bias_Field.png",0,to_save);
% savefig(my_color_scale,bias_removed_image,"Bias Removed","Bias_Removed.png",0,to_save);
% savefig(my_color_scale,residual_image,"Residual","Residual.png",0,to_save);

%% Part g
fprintf('The optimal class means : \n');
disp(class_means);

savefig(my_color_scale,membership,"Segmentation Map","Segmentation_Map.png",0,to_save);

toc;

% Helper function to save the figures %
function savefig(my_color_scale,modified_pic,title_name,file_name,is_color,to_save)
	if to_save==1
		fig = figure('units','normalized','outerposition',[0 0 1 1]); colormap(my_color_scale);
	else
		fig = figure; colormap(my_color_scale);
	end

	if is_color == 1
		colormap jet;
	else
		colormap(gray);
	end
	
	imagesc(modified_pic), title(title_name), colorbar, daspect([1 1 1]), axis tight;
	impixelinfo();
	
	if to_save == 1
		saveas(fig,file_name),close(fig);
	end
end
