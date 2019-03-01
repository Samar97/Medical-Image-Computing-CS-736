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
Rf = radon(img,theta_list);

w_max = floor(size(Rf, 1) / 2);
L = floor(w_max);
h_filtered = myFilter(Rf, 'RamLak', L);
inverted_Image = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image RamLak Wmax","Filtered_Im_RamLak_Wmax.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max / 2);
h_filtered = myFilter(Rf, 'RamLak', L);
inverted_Image = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image RamLak Wmax/2","Filtered_Im_RamLak_Wmax_2.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max);
h_filtered = myFilter(Rf, 'SheppLogan', L);
inverted_Image = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image SheppLogan Wmax","Filtered_Im_SheppLogan_Wmax.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max / 2);
h_filtered = myFilter(Rf, 'SheppLogan', L);
inverted_Image = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image SheppLogan Wmax/2","Filtered_Im_SheppLogan_Wmax_2.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max);
h_filtered = myFilter(Rf, 'Cosine', L);
inverted_Image = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image Cosine Wmax","Filtered_Im_Cosine_Wmax.png",is_color,to_save);

w_max = size(Rf, 1) / 2;
L = floor(w_max / 2);
h_filtered = myFilter(Rf, 'Cosine', L);
inverted_Image = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,inverted_Image,"Filtered Image Cosine Wmax/2","Filtered_Im_Cosine_Wmax_2.png",is_color,to_save);

%% Part b
mask1 = fspecial('gaussian', 11, 1);
mask5 = fspecial('gaussian', 51, 5);

S0 = img;
S1 = conv2(img,mask1,'same');
S5 = conv2(img,mask5,'same');

savefig(my_color_scale,S0,"Shepp Logan original","Shepp_Logan_S0.png",is_color,to_save);
savefig(my_color_scale,S1,"Shepp Logan blurred sig=1","Shepp_Logan_S1.png",is_color,to_save);
savefig(my_color_scale,S5,"Shepp Logan blurred sig=5","Shepp_Logan_S5.png",is_color,to_save);


theta_list = 0:del_theta:177;

Rf = radon(S0,theta_list);
w_max = floor(size(Rf, 1) / 2);
L = floor(w_max);

h_filtered = myFilter(Rf, 'RamLak', L);
R0 = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,R0,"Filtered Image RamLak Wmax R0","Filtered_Im_RamLak_Wmax_R0.png",is_color,to_save);

Rf = radon(S1,theta_list);
w_max = floor(size(Rf, 1) / 2);
L = floor(w_max);

h_filtered = myFilter(Rf, 'RamLak', L);
R1 = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,R1,"Filtered Image RamLak Wmax R1","Filtered_Im_RamLak_Wmax_R1.png",is_color,to_save);

Rf = radon(S5,theta_list);
w_max = floor(size(Rf, 1) / 2);
L = floor(w_max);

h_filtered = myFilter(Rf, 'RamLak', L);
R5 = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
savefig(my_color_scale,R5,"Filtered Image RamLak Wmax R5","Filtered_Im_RamLak_Wmax_R5.png",is_color,to_save);

R0 = R0(2:257,2:257);
R1 = R1(2:257,2:257);
R5 = R5(2:257,2:257);

rrmse0 = RRMSE(S0,R0);
rrmse1 = RRMSE(S1,R1);
rrmse5 = RRMSE(S5,R5);

fprintf("RRMSE with sig = 0 : %f \n",rrmse0);
fprintf("RRMSE with sig = 1 : %f \n",rrmse1);
fprintf("RRMSE with sig = 5 : %f \n",rrmse5);

%% Part c

Rf = radon(S0,theta_list);
w_max = floor(size(Rf, 1) / 2);
rrmse0_list = zeros(w_max);
for L = 1:1:w_max
	h_filtered = myFilter(Rf, 'RamLak', L);
	R0 = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
	R0 = R0(2:257,2:257);
	rrmse0_list(L) = RRMSE(S0,R0);
end

Rf = radon(S1,theta_list);
w_max = floor(size(Rf, 1) / 2);
rrmse1_list = zeros(w_max);
for L = 1:1:w_max
	h_filtered = myFilter(Rf, 'RamLak', L);
	R1 = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
	R1 = R1(2:257,2:257);
	rrmse1_list(L) = RRMSE(S1,R1);
end

Rf = radon(S5,theta_list);
w_max = floor(size(Rf, 1) / 2);
rrmse5_list = zeros(w_max);
for L = 1:1:w_max
	h_filtered = myFilter(Rf, 'RamLak', L);
	R5 = 0.5*iradon(h_filtered, theta_list, 'linear', 'none');
	R5 = R5(2:257,2:257);
	rrmse5_list(L) = RRMSE(S5,R5);
end

fig = figure;
plot(rrmse0_list);
xlabel('L values');
ylabel('RRMSE values');
title("RRMSE vs L for Sigma = 0");
saveas(fig,"RRMSE_0.png");

plot(rrmse1_list);
xlabel('L values');
ylabel('RRMSE values');
title("RRMSE vs L for Sigma = 1");
saveas(fig,"RRMSE_1.png");

plot(rrmse5_list);
xlabel('L values');
ylabel('RRMSE values');
title("RRMSE vs L for Sigma = 5");
saveas(fig,"RRMSE_5.png");

close(fig);
toc;

%% Explanation
% a - For L = wmax/2 we get smoother reconstructed images as more of the higher frequency components are attenuated as compared to L = wmax
% a - Among the filters, the cosine is the smoothest, as it attenuates the higher frequencies more and the RamLak and SheppLogan are very similar
% b - RRMSE is the highest for the original image with sigma = 0 and decreases as sigma increases. This is because as we increase the sigma, 
% the noise is removed and smoothed out (again higher frequencies attenuated). This results in less noise amplification in the inversion process
% Hence the more the sigma, the closer the reconstructed image is to the original image (which is obviously smoothed btw).
% c - For sigma = 0, 1 the RRMSE decreases with increase in L and then increases slightly. 
% Reason - as we increase the retained frequencies we bring more and more detail, so RRMSE intially decreases, 
% but on retaining too high frequencies, the noise also is retained, leading to higher RRMSE
% c - For sigma = 5, the RRMSE decreases with increase in L and then sort of flattens out without increasing much.
% Reason - In this case the image is heavily blurred to begin with, so there is not much noise which would cause the problems we were getting for the other 2 cases. 
% Hence retaining higher frequencies only adds more detail and does not amplify noise as there was n't much to begin with.
% In general the RRMSE values for a particular value of L decreases as we go from the sigma = 0, to sigma = 5. This is corroborated with the values in the y axes.

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