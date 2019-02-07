%% MyMainScript

% Setting the color scale %
my_num_of_colors = 256;
col_scale =  [0:1/(my_num_of_colors-1):1]';
my_color_scale = [col_scale,col_scale,col_scale];

% Set to_save to 1, if you want to save the generated pictures %
to_save = 1;
is_color = 0;

% Loading the pictures %
phantom_data 	= load('../../data/assignmentImageDenoisingPhantom.mat');

phantom_noisy 		= phantom_data.imageNoisy;
phantom_noiseless 	= phantom_data.imageNoiseless;

tic;

% savefig2(my_color_scale,abs(phantom_noisy),abs(phantom_noiseless),"Phantom","phantom.png",is_color,0);
% waitforbuttonpress;

savefig(my_color_scale,abs(phantom_noisy),"Noisy","noisy.png",is_color,to_save);
savefig(my_color_scale,abs(phantom_noiseless),"Noiseless","noiseless.png",is_color,to_save);


%% Part a
rrmse = RRMSE(phantom_noiseless, phantom_noisy);


%% Part b %

step_size 	= 0.001;
sig 		= 1;
max_iter	= 100;

%% Quadratic Prior %

% Auto Parameter Tuning for Quadratic



alfa 		= 0.5;
gam 		= 0.5;
prior 		= "quadratic";
[denoised_img_quad,loss_list] = denoiser(phantom_noisy,alfa,step_size,max_iter,sig,gam,prior);
% savefig3(my_color_scale,abs(phantom_noisy),abs(denoised_img_quad),abs(phantom_noiseless),"Denoised Image","Quadratic","quadratic_denoised.png",is_color,to_save);
savefig(my_color_scale,abs(denoised_img_quad),"Quadratic Prior Denoised","quadratic_denoised.png",is_color,to_save);

quad_rrmse = RRMSE(phantom_noiseless,denoised_img_quad);
disp(quad_rrmse);

% figure;
% plot(loss_list);

%% Huber Prior %
alfa 		= 0.5;
gam 		= 0.5;
prior 		= "huber";
[denoised_img_huber,loss_list] = denoiser(phantom_noisy,alfa,step_size,max_iter,sig,gam,prior);
% savefig3(my_color_scale,abs(phantom_noisy),abs(denoised_img_huber),abs(phantom_noiseless),"Denoised Image","huber","huber_denoised.png",is_color,to_save);
savefig(my_color_scale,abs(denoised_img_huber),"Huber Prior Denoised","huber_denoised.png",is_color,to_save);

huber_rrmse = RRMSE(phantom_noiseless,denoised_img_huber);
disp(huber_rrmse);

% figure;
% plot(loss_list);

%% Disconitnuity Adaptive Prior %
alfa 		= 0.5;
gam 		= 0.5;
prior 		= "discon_adap";
[denoised_img_disc_adap,loss_list] = denoiser(phantom_noisy,alfa,step_size,max_iter,sig,gam,prior);
% savefig3(my_color_scale,abs(phantom_noisy),abs(denoised_img_disc_adap),abs(phantom_noiseless),"Denoised Image","discon_adap","discon_adap_denoised.png",is_color,to_save);
savefig(my_color_scale,abs(denoised_img_disc_adap),"Disconitnuity Adapt Prior Denoised","discon_adap_denoised.png",is_color,to_save);

disc_adap_rrmse = RRMSE(phantom_noiseless,denoised_img_disc_adap);
disp(disc_adap_rrmse);

% figure;
% plot(loss_list);

toc;

% Helper function to display and save 3 processed images %
function savefig3(my_color_scale,original_pic,mid_pic,modified_pic,mid_name,title_name,file_name,is_color,to_save)
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
	
	subplot(1,3,1), imagesc(original_pic), title('Original Image'), colorbar, daspect([1 1 1]), axis tight;
	subplot(1,3,2), imagesc(mid_pic), title(mid_name), colorbar, daspect([1 1 1]), axis tight;
	subplot(1,3,3), imagesc(modified_pic), title(title_name), colorbar, daspect([1 1 1]), axis tight;
	impixelinfo();
    
	if to_save == 1
		saveas(fig,file_name),close(fig);
	end
end


% Helper function to display and save processed images %
function savefig2(my_color_scale,original_pic,modified_pic,title_name,file_name,is_color,to_save)
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
	
	subplot(1,2,1), imagesc(original_pic), title('Original Image'), colorbar, daspect([1 1 1]), axis tight;
	subplot(1,2,2), imagesc(modified_pic), title(title_name), colorbar, daspect([1 1 1]), axis tight;
	impixelinfo();
    
	if to_save == 1
		saveas(fig,file_name),close(fig);
	end
end

% Helper function to display and save processed images %
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
