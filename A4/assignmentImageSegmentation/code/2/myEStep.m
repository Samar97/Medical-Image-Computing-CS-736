function membership = myEStep(X, image_data, K, Beta, mask, class_means, class_stds, to_disp)

	Xmap = myICM(X, image_data, K, Beta, mask, class_means, class_stds, to_disp, 20);
	membership = updateMembership(Xmap, image_data, K, Beta, mask, class_means, class_stds);

end