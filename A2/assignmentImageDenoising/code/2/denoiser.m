function [denoised_img,loss_list] = denoiser(noisy_img,alfa,step_size,max_iter,sig,gam,prior,like)
	denoised_img = noisy_img;
	prev_loss = inf;
	loss_list = [];
	for i = 1:max_iter
		img_grad = calc_grad(denoised_img,noisy_img,sig,gam,prior,like,alfa);
		temp_img = denoised_img - step_size*img_grad;
		curr_loss = calc_loss(temp_img,noisy_img,sig,gam,prior,like,alfa);
		% disp(curr_loss);
		if curr_loss < prev_loss
			step_size = step_size*1.1;
			denoised_img = temp_img;
			prev_loss = curr_loss;
			loss_list = [loss_list,prev_loss];
		else
			step_size = step_size*0.5;
		end
	end
end