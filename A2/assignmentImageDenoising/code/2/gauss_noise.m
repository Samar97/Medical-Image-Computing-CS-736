function gs = gauss_noise(curr_img,data,sig,is_grad)
	if is_grad
		gs = 2*(curr_img-data)/(sig^2);
	else
		gs = sum(sum(abs(curr_img-data).^2/(sig*sig)));
end