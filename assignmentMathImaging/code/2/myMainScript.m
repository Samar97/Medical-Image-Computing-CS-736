%% MyMainScript
close all;
% Setting the color scale %
my_num_of_colors = 256;
col_scale =  [0:1/(my_num_of_colors-1):1]';
my_color_scale = [col_scale,col_scale,col_scale];

% Set to_save to 1, if you want to save the generated pictures %
to_save  = 1;
is_color = 1;

% Loading the picture %
original_image = phantom(256);

tic;

del_theta = 3;
img = original_image;

%% Part a
theta_list = 0:del_theta:177;
Rf 			= radon(img,theta_list);
% inverted_Image 	= iradon(Rf,theta_list);
% savefig(my_color_scale,original_image,"Generated Shepp Logan Phantom","Gen_Shepp_Logan_Phantom.png",is_color,to_save);

w_max = floor(size(Rf, 1) / 2);
L = floor(w_max);
h_filtered = myFilter(Rf, 'RamLak', L) / 2;
inverted_Image = iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image RamLak","Filtered_Im_RamLak.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max / 2);
h_filtered = myFilter(Rf, 'RamLak', L) / 2;
inverted_Image = iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image RamLak","Filtered_Im_RamLak.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max);
h_filtered = myFilter(Rf, 'SheppLogan', L) / 2;
inverted_Image = iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image SheppLogan","Filtered_Im_SheppLogan.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max / 2);
h_filtered = myFilter(Rf, 'SheppLogan', L) / 2;
inverted_Image = iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image SheppLogan","Filtered_Im_SheppLogan.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max);
h_filtered = myFilter(Rf, 'Cosine', L) / 2;
inverted_Image = iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image Cosine","Filtered_Im_Cosine.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max / 2);
h_filtered = myFilter(Rf, 'Cosine', L) / 2;
inverted_Image = iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image Cosine","Filtered_Im_Cosine.png",is_color,to_save);

toc;

% Helper function to save the figures %
function savefig(my_color_scale,modified_pic,title_name,file_name,is_color,to_save)
	if to_save==1
		fig = figure('units','normalized','outerposition',[0 0 1 1]); 
		% colormap(my_color_scale);
	else
		fig = figure; 
		% colormap(my_color_scale);
	end

	% if is_color == 1
	% 	colormap jet;
	% else
	% 	colormap(gray);
	% end
	
	imagesc(modified_pic), title(title_name), colorbar, daspect([1 1 1]), axis tight;
	impixelinfo();
    
	if to_save == 1
		saveas(fig,file_name),close(fig);
	end
end