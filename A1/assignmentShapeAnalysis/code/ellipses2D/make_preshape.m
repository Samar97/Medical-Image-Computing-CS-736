function [point_set_data_norm] = make_preshape(point_set_data, dim, num_points)
	
	centroids_data  = mean(point_set_data, 2);
	point_set_data_cen = point_set_data - centroids_data;

	point_set_data_sqr = point_set_data_cen.^2;
	point_set_data_sqr_sum_pts = sum(point_set_data_sqr, 2);
	point_set_data_norm_val = sqrt(sum(point_set_data_sqr_sum_pts, 1));
	point_set_data_norm = point_set_data_cen./repmat(point_set_data_norm_val, [dim, num_points]);

end