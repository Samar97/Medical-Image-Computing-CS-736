function rc = rician(curr_img,data,sig,alfa,is_grad)
	if is_grad
		term1 = curr_img/(sig^2);
		term2 = besseli(1,alfa*(data.*curr_img)/sig^2)./besseli(0,alfa*(data.*curr_img)/sig^2);
		term3 = term2.*data/(sig^2);
		rc = term1-term3;
	else
		term1 = (data.^2 + curr_img.^2)/(2*(sig^2));
		term2 = log(besseli(0,alfa*(data.*curr_img)/sig^2))/alfa;
		rc = sum(sum(term1-term2));
end