function new_bias = updateBias(K, q, nbr_mask, class_means, membership, image_data)

	[h, w] = size(image_data);
	new_bias = zeros(h, w);
	label_weighted_means = zeros(h, w);
	label_weighted_means_squared = zeros(h, w);

	for k = 1:K
		ck = class_means(k);
		label_weighted_means = label_weighted_means + (membership(:,:,k).^q)*ck;
		label_weighted_means_squared = label_weighted_means_squared + (membership(:,:,k).^q)*(ck^2);
	end

	image_mult_mean = image_data .* label_weighted_means;
	bias_num = conv2(image_mult_mean, nbr_mask, 'same');
	bias_den = conv2(label_weighted_means_squared, nbr_mask, 'same');
	
	new_bias = bias_num./bias_den;
	new_bias(isnan(new_bias)) = 1.0;

	if(any(isnan(new_bias)))
		fprintf('Bias');
	end
end