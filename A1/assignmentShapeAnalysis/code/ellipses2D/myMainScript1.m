%% MyMainScript for Part 1 of assignment

% Setting the color scale %
my_num_of_colors = 256;
col_scale =  [0:1/(my_num_of_colors-1):1]';
my_color_scale = [col_scale,col_scale,col_scale];

% Set to_save to 1, if you want to save the generated pictures %
to_save = 1;

ellipse_data = load('../../data/ellipses2D.mat');
results_folder = '../../results/ellipses2D/';

num_point_sets = ellipse_data.numOfPointSets;
num_points = ellipse_data.numOfPoints;
point_set_data = ellipse_data.pointSets;
dim = size(point_set_data, 1);

size(point_set_data);

has_mean = 0;
plot_data_points(point_set_data, num_point_sets, has_mean, 0, 'Original_Point_Sets.png', 'Original Point Sets', 1, to_save, results_folder);

tic;

% Get Data in Preshape Space
point_set_data_norm = make_preshape(point_set_data, dim, num_points);

has_mean = 0;
plot_data_points(point_set_data_norm, num_point_sets, has_mean, 0, 'Preshape_Space.png', 'Point Sets in Preshape Space', 1, to_save, results_folder);

mean_new = point_set_data_norm(:,:,1);
diff_means = 1;
threshold = 1e-7;

while (diff_means > threshold)
	mean_old = mean_new;

	% Transform each of the pointset to match with the mean
	for i = 1:num_point_sets
		point_set_data_norm(:,:,i) = similarity_transform(mean_old, point_set_data_norm(:,:, i));
	end

	% Find the means from the normalised data point sets
	mean_new  = find_mean(point_set_data_norm);

	% Calculate infinity norm between the old mean and the new calculated mean
	diff_means = max(max(abs(mean_old - mean_new)));
end	

has_mean = 1;
plot_data_points(point_set_data_norm, num_point_sets, has_mean, mean_new, 'Mean_Aligned_PointSets_Random_Color.png', 'Aligned PointSets along with mean', 1, to_save, results_folder);

has_mean = 1;
plot_data_points(point_set_data_norm, num_point_sets, has_mean, mean_new, 'Mean_Aligned_PointSets.png', 'Aligned PointSets along with mean', 0, to_save, results_folder);
	
% Covariance Analysis

point_set_data_norm_flat = reshape(point_set_data_norm - repmat(mean_new, [1,1,num_point_sets]), [dim*num_points, num_point_sets]);
% point_set_data_norm_flat = point_set_data_norm_flat - );
cov_mat = double(point_set_data_norm_flat * point_set_data_norm_flat') ./ double(num_point_sets);
% size(cov_mat)

[V,D] = eigs(cov_mat, dim*num_points);

f = figure();
plot(D);
if to_save
	saveas(f, strcat(results_folder, 'EigenValues.png'));
end
close(f);

eigVec1 = V(:, 1);
eigVal1 = D(1,1);
eigVec2 = V(:, 2);
eigVal2 = D(2,2);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mode_of_var1_inc = mean_new + 2*sqrt(eigVal1)*reshape(eigVec1, [dim, num_points]);
mode_of_var1_dec = mean_new - 2*sqrt(eigVal1)*reshape(eigVec1, [dim, num_points]);

mode_of_var1_inc = mode_of_var1_inc ./ norm(mode_of_var1_inc, 'fro');
mode_of_var1_dec = mode_of_var1_dec ./ norm(mode_of_var1_dec, 'fro');

f = figure();
title("Modes of variation 1 with the mean");

hold on;
for i = 1:num_point_sets
	scatter(point_set_data_norm(1,:, i), point_set_data_norm(2, :, i), 10, [1,1,0], 'filled');
end	

scatter(mean_new(1,:), mean_new(2,:), 10, [1, 0, 0], 'filled', 'd');
scatter(mode_of_var1_inc(1,:), mode_of_var1_inc(2,:), 10, [0, 1, 0], 'filled', 'd');
scatter(mode_of_var1_dec(1,:), mode_of_var1_dec(2,:), 10, [0, 0, 1], 'filled', 'd');

hold off;

if to_save
	saveas(f, strcat(results_folder, 'Modes_of_variation1.png'));
end
close(f);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mode_of_var2_inc = mean_new + 2*sqrt(eigVal2)*reshape(eigVec2, [dim, num_points]);
mode_of_var2_dec = mean_new - 2*sqrt(eigVal2)*reshape(eigVec2, [dim, num_points]);

mode_of_var2_inc = mode_of_var2_inc ./ norm(mode_of_var2_inc, 'fro');
mode_of_var2_dec = mode_of_var2_dec ./ norm(mode_of_var2_dec, 'fro');

f = figure();

hold on;

title("Modes of variation 2 with the mean");

for i = 1:num_point_sets
	scatter(point_set_data_norm(1,:, i), point_set_data_norm(2, :, i), 10, [1,1,0], 'filled');
end	

scatter(mean_new(1,:), mean_new(2,:), 10, [1, 0, 0], 'filled', 'd');
scatter(mode_of_var2_inc(1,:), mode_of_var2_inc(2,:), 10, [0, 1, 0], 'filled', 'd');
scatter(mode_of_var2_dec(1,:), mode_of_var2_dec(2,:), 10, [0, 0, 1], 'filled', 'd');

hold off;

if to_save
	saveas(f, strcat(results_folder, 'Modes_of_variation2.png'));
end
close(f);

toc;