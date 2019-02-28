function Rf = myRadonTrans(img,del_step,del_t,del_theta)
	t_list = -90:del_t:90;
	theta_list = 0:del_theta:175;
	Rf = zeros(size(t_list,2),size(theta_list,2));
	for i = 1:size(t_list,2)
		for j = 1:size(theta_list,2)
			t = t_list(i);
			theta = theta_list(j);
			Rf(i,j) = myIntegration(t,theta,del_step,img);
		end
	end

end