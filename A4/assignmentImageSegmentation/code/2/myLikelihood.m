function log_likelihood = myLikelihood(image_data, X, mask, class_means, class_stds)

	% We are anyway going to make it zero in the end
	X(X==0) = 1; 
	
	log_likelihood = zeros(size(image_data));
	square_diff = (image_data - class_means(X)).^2;
	
	% log_likelihood = -square_diff./(2*(class_stds(X).^2));
	
	% log_likelihood = -square_diff./(2*(class_stds(X)));

	log_likelihood = -square_diff./(2*(class_stds(X))) - log(sqrt(class_stds(X) * 2 * pi));
	
	log_likelihood = log_likelihood .* mask;

	log_likelihood(isnan(log_likelihood)) = 0;

	if any(any(isnan(log_likelihood) | isinf(sum(log_likelihood(:)))))
		fprintf("Like")
	end

end