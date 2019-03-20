function Xmap = myICM(X, image_data, K, Beta, mask, class_means, class_stds, to_disp, num_iter)

	[h, w] = size(image_data);
	Xmap = X;
	log_prior = myPrior(Xmap, Beta, mask, Xmap, 0);
	log_likelihood = myLikelihood(image_data, Xmap, mask, class_means, class_stds);
	original_log_posterior = sum(sum(log_prior + log_likelihood));

	for iter = 1:num_iter	
		
		posterior_all = zeros([h, w, K]);

		for k = 1:K
			
			X_k = ones(size(X))*k;
			X_k = X_k .* mask;
			log_prior = myPrior(X_k, Beta, mask, Xmap, 1);
			log_likelihood = myLikelihood(image_data, X_k, mask, class_means, class_stds);
			log_posterior = log_prior + log_likelihood;
			posterior_all(:,:,k) = log_posterior;
		end

		[not_needed, Xmap] = max(posterior_all, [], 3);
		Xmap = Xmap .* mask;

	end

	log_prior = myPrior(Xmap, Beta, mask, Xmap, 0);
	log_likelihood = myLikelihood(image_data, Xmap, mask, class_means, class_stds);
	modified_log_posterior = sum(sum(log_prior + log_likelihood));

	if to_disp
		fprintf('log posterior before : %f \n', original_log_posterior);
		fprintf('log posterior after  : %f \n', modified_log_posterior);
	end

end