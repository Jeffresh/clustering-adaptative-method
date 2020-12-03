# Generate data

close all; clear all; clc
addpath('pattern')

class1 = rand(2, 50);
class2 = rand(2, 40) + 2;
class3 = rand(2, 50) - 2;
dataY = [ones(1,50), 2 * ones(1,40), 3 * ones(1, 50)];
dataX = [class1, class2, class3];
colors = ['r', 'b', 'g'];

figure; hold on;
for i=1:length(colors)
    ind = find(dataY == i);
    plot(dataX(1,ind), dataX(2,ind), strcat('o', colors(i) ))
end
hold off;


# Sort examples

[~, ind] = sort(rand(1, size(dataX, 2)));

X = dataX(:, ind);
y = dataY(:, ind);

figure; hold on;
for i=1:length(colors)
    ind = find(y == i);
    plot(X(1,ind), X(2,ind), strcat('o', colors(i) ))
end
hold off;

# Trainning

radius = 1;
[class, centers] = adaptativeMethod(X, radius);

# Evaluation

colors = ['b', 'g', 'c', 'r', 'm', 'y', 'k', 'w'];
colors = [ colors, colors, colors];

figure; hold on;
for i=1:length(centers)
    ind = find(class == centers(i));
    plot(X(1,ind), X(2,ind), strcat('o', colors(i) ))
end
hold off;

% Recalculate protoypes as Centroids

ind = find(class == centers(i));

for i=1:length(centers)
ind = find(class == centers(i));
centroids(:, i) = meanpat(X(:, ind));
end

for i=1:length(centroids)
    d(i,:) = d_euclid(X,centroids(:,i));
end

[~,yest]=min(d);

figure,
hold on;
for i=1:length(centers)
    ind = find(yest == i);
    plot(X(1,ind), X(2,ind), strcat('o', colors(i) ))
end
hold off;
