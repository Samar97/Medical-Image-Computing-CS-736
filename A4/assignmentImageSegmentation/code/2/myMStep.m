function [class_means, class_stds] = myMStep(K, membership, image_data, class_means, mask)

	class_means = updateMeans(K, membership, image_data, mask);
	class_stds = updateStds(K, membership, image_data, class_means, mask);

end