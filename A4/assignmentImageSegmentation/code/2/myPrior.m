function log_prior = myPrior(X, Beta, mask, X_fixed, opt)

	%% X_fixed refers to the original labels

	if opt == 0
		X_fixed = X;
	end
	
	X_up = circshift(X_fixed,[-1,0]);
	X_down = circshift(X_fixed,[1,0]);
	X_left = circshift(X_fixed,[0,-1]);
	X_right = circshift(X_fixed,[0,1]);

	log_prior = zeros(size(X));
	
	log_prior = log_prior + (X ~= X_up & X_up ~= 0);
	log_prior = log_prior + (X ~= X_down & X_down ~= 0);
	log_prior = log_prior + (X ~= X_left & X_left ~= 0);
	log_prior = log_prior + (X ~= X_right & X_right ~= 0);

	log_prior = -log_prior*Beta;
	log_prior = log_prior.*mask;

	if any(any(isnan(log_prior) | isinf(log_prior)))
		fprintf("Prior")
	end

end