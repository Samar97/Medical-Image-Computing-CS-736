function new_membership = updateMembership(K, q, nbr_mask, class_means, bias, image_data, image_mask)

	[h, w, num_chan] = size(image_data);
	new_membership = zeros(h, w, K);
	distance_kj = zeros(h, w, K);

	image_squared = image_data.^2;
	conv_bias = conv2(bias, nbr_mask, 'same');
	conv_bias_squared = conv2(bias.*bias, nbr_mask, 'same');
	bias_weighted_image = image_data.*conv_bias;
	
	for k = 1:K
		ck = class_means(k);
		distance_kj(:,:,k) = image_squared + (ck^2) * conv_bias_squared - 2*ck*bias_weighted_image;
	end

	new_membership_num = (1./distance_kj) .^ (1.0/(q-1.0));
	sum_membership = sum(new_membership_num,3);
	new_membership = new_membership_num./repmat(sum_membership,1,1,K);
	new_membership(isnan(new_membership)) = 1.0;
	new_membership = new_membership .* repmat(image_mask,1,1,K);
	new_membership = abs(new_membership);

	if(any(isnan(new_membership)))
		fprintf('Membership');
	end

end