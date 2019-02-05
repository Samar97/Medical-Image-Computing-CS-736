function quad_loss = quadratic_prior(img,is_grad)
	quad_loss = zeros(size(img));
	if is_grad
		for dim = [1,2]
			for k = [-1,1]
				difference = img - circshift(img,k,dim);
				quad_loss = quad_loss + 2*difference;
			end
		end
	else
		for dim = [1,2]
			for k = [-1,1]
				difference = img - circshift(img,k,dim);
				quad_loss = quad_loss + abs(difference).^2;
			end
		end
	end
end