function [target_aligned] = similarity_transform(ref, target)

	[dim, num_points] = size(target);

	cross_cov = target * ref';
	size(cross_cov);

	[U, S, V] = svds(double(cross_cov), dim);

	negI = eye(dim);
	negI(dim, dim) = -1;

	R = V * U';
	if det(R) < 0	
		R = V * negI * U';
	end
	
	target_aligned = R * target;

end