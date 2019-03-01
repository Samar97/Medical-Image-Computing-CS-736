%% MyMainScript
close all;
clear;
clc;

% Setting the color scale %
my_num_of_colors = 256;
col_scale =  [0:1/(my_num_of_colors-1):1]';
my_color_scale = [col_scale,col_scale,col_scale];

% Set to_save to 1, if you want to save the generated pictures %
to_save  = 1;
is_color = 1;

% Loading the picture %
CT_Chest = load('../../data/CT_Chest.mat');
CT_Chest = CT_Chest.imageAC;

myPhantom = load('../../data/myPhantom.mat');
myPhantom = myPhantom.imageAC;

tic;

savefig(my_color_scale,CT_Chest,"Original CT chest","original_CT_chest.png",is_color,to_save);
savefig(my_color_scale,myPhantom,"Original phantom","original_phantom.png",is_color,to_save);

%% Part a

rrmse_ct_list = zeros(size(0:180));
img = CT_Chest;
for theta = 0:180
	theta_list = theta:theta+150;
	Rf = radon(img,theta_list);
	inverted_image = iradon(Rf,theta_list);
	inverted_image = inverted_image(2:513,2:513);
	rrmse_ct_list(theta+1) = RRMSE(img,inverted_image);
end

fig = figure;
plot(rrmse_ct_list);
xlabel('starting theta values');
ylabel('RRMSE values');
title("CT chest - RRMSE values for different starting thetas");
saveas(fig,"CT_rrmse.png");

rrmse_phantom_list = zeros(size(0:180));
img = myPhantom;
for theta = 0:180
	theta_list = theta:theta+150;
	Rf = radon(img,theta_list);
	inverted_image = iradon(Rf,theta_list);
	inverted_image = inverted_image(2:257,2:257);
	rrmse_phantom_list(theta+1) = RRMSE(img,inverted_image);
end

plot(rrmse_phantom_list);
xlabel('starting theta values');
ylabel('RRMSE values');
title("Phantom - RRMSE values for different starting thetas");
saveas(fig,"phantom_rrmse.png");

close(fig);

%% Part b

img = CT_Chest;
[rrmse_min_ct, index_min_ct] = min(rrmse_ct_list);
fprintf("Best CT theta : %f \n",index_min_ct-1);
theta_list = index_min_ct-1:index_min_ct-1+150;
Rf = radon(img,theta_list);
inverted_image = iradon(Rf,theta_list);
savefig(my_color_scale,inverted_image,"Best CT reconstructed","Best_CT.png",is_color,to_save);

img = myPhantom;
[rrmse_min_phantom, index_min_phantom] = min(rrmse_phantom_list);
fprintf("Best Phantom theta : %f \n",index_min_phantom-1);
theta_list = index_min_phantom-1:index_min_phantom-1+150;
Rf = radon(img,theta_list);
inverted_image = iradon(Rf,theta_list);
savefig(my_color_scale,inverted_image,"Best phantom reconstructed","Best_phantom.png",is_color,to_save);

toc;

%% Explanation - 
% We will acquire the range which gives the least RRMSE error as we have calculated


% Helper function to save the figures %
function savefig(my_color_scale,modified_pic,title_name,file_name,is_color,to_save)
	if to_save==1
		fig = figure('units','normalized','outerposition',[0 0 1 1]); 
		colormap(my_color_scale);
	else
		fig = figure; 
		colormap(my_color_scale);
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