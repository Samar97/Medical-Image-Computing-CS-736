function new_membership = updateMembership(Xmap, image_data, K, Beta, mask, class_means, class_stds)

	[h, w] = size(image_data);
	posterior_all = zeros([h, w, K]);

	for k = 1:K
		
		X_k = ones(size(Xmap))*k;
		X_k = X_k .* mask;
		log_prior = myPrior(X_k, Beta, mask, Xmap, 1);
		log_likelihood = myLikelihood(image_data, X_k, mask, class_means, class_stds);
		log_posterior = log_prior + log_likelihood;
		posterior_all(:,:,k) = exp(log_posterior);
		posterior_all(:,:,k) = posterior_all(:,:,k) .* mask;

	end

	membership_den = sum(posterior_all, 3);
	new_membership = posterior_all ./ repmat(membership_den,1,1,K);
	new_membership(isnan(new_membership)) = 0;
	new_membership = new_membership .* repmat(mask, 1, 1, K);

	if any(any(any(isnan(new_membership))))
		disp("New Mem")
	end

end