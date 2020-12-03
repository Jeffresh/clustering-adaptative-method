function [classes, centers] = adaptativeMethod(X, radius)

    n_examples = size(X, 2);
    ind_first = randi(n_examples);
    prototype = X(:, ind_first);
    centers = [ind_first];
    classes = zeros(size(X,1), 1);
    classes(ind_first) = ind_first;

    for i=1:length(X)
        if(~ ismember(i, centers))
            example_vect = X(:,i);
            distances = d_euclid(X(:, centers), example_vect);
            [min_dis, class] = min(distances);
            if (min_dis < radius)
                classes(i) = centers(class);
            else
                centers = [centers, i];
                classes(i) = i;
            end
        end
    end

end