function loss = calcLoss(K, q, nbr_mask, class_means, membership, bias, image_data)
	[h,w] = size(image_data);
	distance_kj = zeros(h, w, K);

	image_squared = image_data.^2;
	conv_bias = conv2(bias, nbr_mask, 'same');
	conv_bias_squared = conv2(bias.*bias, nbr_mask, 'same');
	bias_weighted_image = image_data.*conv_bias;
	
	for k = 1:K
		ck = class_means(k);
		distance_kj(:,:,k) = image_squared + (ck^2) * conv_bias_squared - 2*ck*bias_weighted_image;
	end

	loss_image = (membership.^q).*distance_kj;
	loss = sum(loss_image(:));
	
end