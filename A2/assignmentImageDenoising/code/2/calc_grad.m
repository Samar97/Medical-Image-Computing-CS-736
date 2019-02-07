function img_gradient = calc_grad(curr_img,data,sig,gam,prior,like,alfa)
	img_gradient = zeros(size(curr_img));
	potential_img = zeros(size(curr_img));
	if strcmp(like,'gauss')
		likelihood = gauss_noise(curr_img,data,sig,1);
	else
		likelihood = rician(curr_img,data,sig,alfa,1);
	end
	if strcmp(prior,'huber')
		potential_img = huber_prior(curr_img,gam,1);
	elseif strcmp(prior,'quadratic')
		potential_img = quadratic_prior(curr_img,1);
	elseif strcmp(prior,'discon_adap')
		potential_img = discon_adap_prior(curr_img,gam,1);
	else
		disp("Unknown Prior");
	end
	img_gradient = alfa*likelihood + (1-alfa)*potential_img;
end