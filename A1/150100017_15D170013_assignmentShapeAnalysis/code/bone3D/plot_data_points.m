function [] = plot_data_points(point_set_data, polygon_faces, num_point_sets, has_mean, mean_points, file_name, plot_title, random_color, to_save, results_folder)

	f = figure();

	title(plot_title);

	hold on;

	% Alpha Values - 0 - transparent, 1 - opaque %
	if random_color
		for i = 1:num_point_sets
			patch('Faces',polygon_faces,'Vertices',point_set_data(:,:,i)','FaceColor',[1,1,1],'EdgeColor',rand(1,3), 'FaceAlpha', 0, 'EdgeAlpha', 0.3);
		end
	else
		for i = 1:num_point_sets
			patch('Faces',polygon_faces,'Vertices',point_set_data(:,:,i)','FaceColor',[1,1,1],'EdgeColor',[0,0,1], 'FaceAlpha', 0, 'EdgeAlpha', 0.3);
		end
	end

	if has_mean
		patch('Faces',polygon_faces,'Vertices',mean_points(:,:,1)','FaceColor',[1,1,1],'EdgeColor',[1,0,0], 'FaceAlpha', 0, 'EdgeAlpha', 1);
	end
	hold off;
	
	view(-145, 45)
	
	if to_save
		saveas(f, strcat(results_folder, file_name));
	end
	
	% close(f);

end 