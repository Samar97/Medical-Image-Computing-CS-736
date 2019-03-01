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
original_image = phantom(128);

tic;

savefig(my_color_scale,original_image,"Shepp Logan Phantom","Shepp_Logan_Phantom.png",is_color,to_save);
del_step = 0.5;
del_t = 5;
del_theta = 5;
img = original_image;

%% Part c
del_step = 0.5;
Rf = myRadonTrans(img,del_step,del_t,del_theta);
Rf0 = Rf(:,1);
Rf90 = Rf(:,1+uint8(90/del_theta));
fig = figure;
plot(Rf0);
xlabel('t values');
ylabel('Rf values');
title("Rf slice theta 0 del s 0.5");
set(gca,'XTickLabel',-90:del_theta:90);
saveas(fig,"Rf_slice_theta_0_del_s_0_5.png");

plot(Rf90);
xlabel('t values');
ylabel('Rf values');
title("Rf slice theta 90 del s 0.5");
set(gca,'XTickLabel',-90:del_theta:90);
saveas(fig,"Rf_slice_theta_90_del_s_0_5.png");

close(fig);

savefig(my_color_scale,Rf,"Radon Transform del s 0.5","Radon_transform_0_5.png",is_color,to_save);

del_step = 1;
Rf = myRadonTrans(img,del_step,del_t,del_theta);
Rf0 = Rf(:,1);
Rf90 = Rf(:,1+uint8(90/del_theta));
fig = figure;
plot(Rf0);
xlabel('t values');
ylabel('Rf values');
title("Rf slice theta 0 del s 1");
set(gca,'XTickLabel',-90:del_theta:90);
saveas(fig,"Rf_slice_theta_0_del_s_1.png");

plot(Rf90);
xlabel('t values');
ylabel('Rf values');
title("Rf slice theta 90 del s 1");
set(gca,'XTickLabel',-90:del_theta:90);
saveas(fig,"Rf_slice_theta_90_del_s_1.png");

close(fig);

savefig(my_color_scale,Rf,"Radon Transform del s 1","Radon_transform_1.png",is_color,to_save);

del_step = 3;
Rf = myRadonTrans(img,del_step,del_t,del_theta);
Rf0 = Rf(:,1);
Rf90 = Rf(:,1+uint8(90/del_theta));
fig = figure;
plot(Rf0);
xlabel('t values');
ylabel('Rf values');
title("Rf slice theta 0 del s 3");
set(gca,'XTickLabel',-90:del_theta:90);
saveas(fig,"Rf_slice_theta_0_del_s_3.png");

plot(Rf90);
xlabel('t values');
ylabel('Rf values');
title("Rf slice theta 90 del s 3");
set(gca,'XTickLabel',-90:del_theta:90);
saveas(fig,"Rf_slice_theta_90_del_s_3.png");

close(fig);

savefig(my_color_scale,Rf,"Radon Transform del s 3","Radon_transform_3.png",is_color,to_save);

toc;

%% Part a 
% Justification - 
% We should use step size of 1, because the step size of 0.5 gives the same result and a higher step size like 3 distorts the result. 
% So, one is an ideal tradeoff.
% We use bilinear interpolation, that is the default choice of the interp2 function.
% Reason - ?
%% Part c
% The 1D plot which appears the smoothest is delta s = 0.5 and delta s = 1 (both have the same plot and images)
% The 1D plot which appears the roughest is delta s = 3
% Reason - Lesser delta_s values lead to smaller steps for integration and hence more "continuity" is enforced due to the accurately calculated values. 
% Large delta can cause discontinuities and hence less smooth.
%% Part d
%% Part e

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