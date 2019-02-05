function huber_loss = huber_prior(img,gam,is_grad)
	huber_loss = zeros(size(img));
	if is_grad
		for dim = [1,2]
			for k = [-1,1]
				difference = img - circshift(img,k,dim);
				greater = abs(difference) > gam;
				lesser  = abs(difference) <= gam;
				h_difference = 0.5*lesser + (0.5*gam./abs(difference)).*greater;
				huber_loss = huber_loss + 2*difference.*h_difference;
			end
		end
	else
		for dim = [1,2]
			for k = [-1,1]
				difference = img - circshift(img,k,dim);
				greater = abs(difference) > gam;
				lesser  = abs(difference) <= gam;
				huber_loss = huber_loss + 0.5*((lesser.*abs(difference)).^2);
				huber_loss = huber_loss + gam*(greater.*abs(difference)) - 0.5*(gam.^2)*greater;
			end
		end
	end
end