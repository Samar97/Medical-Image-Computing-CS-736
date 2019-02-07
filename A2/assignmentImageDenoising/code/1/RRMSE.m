function rrmse = RRMSE(image1, image2)
	rrmse = sqrt(sum(sum((abs(image1) - abs(image2)).^2))/sum(sum((abs(image1).^2))));
end