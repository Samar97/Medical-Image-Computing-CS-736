function disc_loss = discon_adap_prior(img,gam,is_grad)
	disc_loss = zeros(size(img));
	if is_grad
		for dim = [1,2]
			for k = [-1,1]
				difference = img - circshift(img,k,dim);
				h_difference = gam./(2*(gam+abs(difference)));
				disc_loss = disc_loss + 2*difference.*h_difference;
			end
		end
	else
		for dim = [1,2]
			for k = [-1,1]
				difference = img - circshift(img,k,dim);
				disc_loss = disc_loss + gam*abs(difference) - gam*gam*log(1+abs(difference)/gam);
			end
		end
	end
end