function new_means = updateMeans(K, membership, image_data, mask)
	
	new_means = zeros(K,1);
	
	for k=1:K
		
		centered_image = image_data;

		numerator = sum(sum(membership(:,:,k).*centered_image.*mask));
		denominator = sum(sum(membership(:,:,k).*mask));

		new_means(k) = numerator./denominator;

	end

end