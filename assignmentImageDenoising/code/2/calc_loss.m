function loss = calc_loss(curr_img,data,sig,gam,prior,alfa)
	likelihood = gauss_noise(curr_img,data,sig,0);
	potential = 0;
	potential_img = zeros(size(curr_img));
	if strcmp(prior,'huber')
		potential_img = huber_prior(curr_img,gam,0);
	elseif strcmp(prior,'quadratic')
		potential_img = quadratic_prior(curr_img,0);
	elseif strcmp(prior,'discon_adap')
		potential_img = discon_adap_prior(curr_img,gam,0);
	else
		disp("Unknown Prior");
	end
	potential = sum(sum(potential_img));
	loss = alfa*likelihood + (1-alfa)*potential;
end