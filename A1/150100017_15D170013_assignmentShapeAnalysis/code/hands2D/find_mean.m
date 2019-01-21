function [opt_mean_norm] = find_mean(point_set_data_norm)

	opt_mean = mean(point_set_data_norm, 3);
	opt_mean_norm = opt_mean ./ norm(opt_mean, 'fro');	

end
