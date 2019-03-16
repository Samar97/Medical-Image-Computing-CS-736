function new_means = updateMeans(K, q, nbr_mask, membership, bias, image_data)
	
	new_means = zeros(K,1);
	conv_bias = conv2(bias, nbr_mask, 'same');
	conv_bias_squared = conv2(bias.*bias, nbr_mask, 'same');
	bias_weighted_image = image_data.*conv_bias;

	for k = 1:K
		numerator 	= (membership(:,:,k).^q).*bias_weighted_image;
		denominator = (membership(:,:,k).^q).*conv_bias_squared;
		new_means(k) = sum(numerator(:))/sum(denominator(:));
	end

	if(any(isnan(new_means)))
		fprintf('Means');
	end

end