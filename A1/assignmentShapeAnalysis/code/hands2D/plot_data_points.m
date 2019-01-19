function [] = plot_data_points(point_set_data, num_point_sets, has_mean, mean_points, file_name, plot_title, random_color, to_save, results_folder)

	f = figure();

	title(plot_title);

	hold on;
	if random_color
	
		for i = 1:num_point_sets
			scatter(point_set_data(1,:, i), point_set_data(2, :, i), 10, rand(1,3), 'filled');
		end


	else
		for i = 1:num_point_sets
			scatter(point_set_data(1,:, i), point_set_data(2, :, i), 10, [1,1,0], 'filled');
		end	
	end

	if has_mean
		scatter(mean_points(1,:), mean_points(2,:), 50, [1, 0, 0], 'filled', 'd');
	end
	hold off;
	
	if to_save
		saveas(f, strcat(results_folder, file_name));
	end
	
	close(f);

end 