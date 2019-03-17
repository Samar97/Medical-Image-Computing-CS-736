function new_stds = updateStds(K, membership, image_data, class_means, mask)
	
	new_stds = zeros(K,1);
	
	for k=1:K
		
		centered_image = (image_data - class_means(k)).^2;

		numerator = sum(sum(membership(:,:,k).*centered_image.*mask));
		denominator = sum(sum(membership(:,:,k).*mask));

		new_stds(k) = numerator./denominator;

	end

end