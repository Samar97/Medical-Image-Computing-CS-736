function filtered_transform = myFilter(Rf,filter_name,L)
	Fourier_trans = fftshift(fft(Rf),1);
	
	t_lim = size(Fourier_trans, 1);
	theta_lim = size(Fourier_trans, 2);
	
	leftLim = 1 - t_lim /2;
	rigthLim = t_lim / 2;
	
	mod_w_val = double(abs(leftLim:1:rigthLim));

	RectL = (mod_w_val<=L);
	C = 0;

	if strcmp(filter_name,"RamLak")
		C = 1;
	elseif strcmp(filter_name,"SheppLogan")
		C = sin(0.5 * pi* mod_w_val/L)./(0.5 * pi* mod_w_val/L);
	elseif strcmp(filter_name,"Cosine")
		C = cos(0.5 * pi* mod_w_val/L);
	end

	B = C.*RectL;
	A = B.*mod_w_val;

	filtered_Fourier = repmat(A,theta_lim,1)'.*Fourier_trans;
	filtered_transform = real(ifft(ifftshift(filtered_Fourier,1)));
end