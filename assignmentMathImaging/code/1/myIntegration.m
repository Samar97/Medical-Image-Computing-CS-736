function val = myIntegration(t, theta, del_step, img)
	theta = theta*pi/180;
	[h,w,num_chan] = size(img);
	right_lim 	= w/2;
	left_lim 	= -w/2 + 1;
	top_lim 	= h/2;
	bottom_lim 	= -h/2 + 1;

	min_s = 0;
	max_s = 0;

	if abs(sin(theta)) >= 1e-4
		max_s = (t*cos(theta) - double(left_lim))/sin(theta);
		min_s = (t*cos(theta) - double(right_lim))/sin(theta);
	else
		if cos(theta) > 0
			max_s = top_lim;
			min_s = bottom_lim;
		else
			max_s = bottom_lim;
			min_s = top_lim;
		end
	end

	if min_s > max_s
		temp = min_s;
		min_s = max_s;
		max_s = temp;
	end

	s = [min_s:double(del_step):max_s];


	x = t*cos(theta) - s*sin(theta);
	y = t*sin(theta) + s*cos(theta);

	val_x = (x <= right_lim) & (x >= left_lim);
	val_y = (y <= top_lim) & (y >= bottom_lim);

	val_ind = val_x & val_y;
	x = x(val_ind) + right_lim;
	y = y(val_ind) + top_lim;

	interp_val = interp2(img, x, y);

	val = sum(interp_val)*del_step;
end