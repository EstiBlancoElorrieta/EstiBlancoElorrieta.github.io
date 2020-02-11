% Purpose:      Provide sample script for linear classification analysis
% Input:        labels.mat and Classification_data.mat
% Output:       Two plots. 1) Original data with misclassified observations
%               2) Linear divisions of the space the classifier used in the
%               analysis
% Dependencies:     none
% Version history:  02/10/2020
% Matlab version:   2018a
% Creator:  Esti Blanco-Elorrieta

%% Start a new script from scratch%

clear all; close all; clc

%% Load the data for our analysis. We will be loading the meg data from left
% and right auditory sensors collected while participants listened to a
% vowel, a fricative or a plosive sound.   

% We will first load the values themselves. The shape of the matrix is 150
% rows (one per observation) and two columns, one for each dimension 
% we are interested in, in this case, values in left and right auditory
% sensors. Make sure to change the path to the folder where your data is
% stored.
data = load('Data.mat');
data = data.data;

%Then we load the labels that indicate what sound was heard in each of
%those 150 trials

label_array = load('Labels.mat');
labels = label_array.labels;

% We plot the data to see how each sound category patterns. 
%Open new figure (and don't close it after you are done with this step)
f = figure;

%Plot the data in a scatterplot, labeled by category
gscatter(data(:,1), data(:,2), labels,'rgb','osd');

%Label the axes
xlabel('Right auditory cortex');
ylabel('Left auditory cortex');
N = size(data,1);

%% Start the classification process
% Suppose we want to classify our data based on this auditory response,
% we can use a linear classifier for this purpose, such as the one we just 
% went over. We will fit a linear classifier to the data from columns
% 1 and 2.

linear_class = fitcdiscr(data(:,1:2),labels);

%We can then have a look at the guesses the classifier made
guesses = resubPredict(linear_class);

%We can even visualize it in the plot we had before if we want to. We call
%back our figure F which contains the distribution of observations
figure(f)
hold on;

%We compare the guesses the classifier made to the labels to get an index
% of which trials were misclassified
bad = ~strcmp(guesses,labels);

%We plot x-s on top of the observations that were wrongly classified, so
%now we can see that are intermixed between a majority of observations of
%another category that the classifier fails at
plot(data(bad,1), data(bad,2), 'kx');

%We can even quantify what the error rate of the classifier was (in 
%percentage points)
ldaResubErr = resubLoss(linear_class);

%% Sometimes it is visually useful to see the way in which the space was 
%divided to assign observations to each of the categories. We create a 
%grid of points that occupies the space between the limits of our real data  
[x,y] = meshgrid(4:.1:8,2:.1:4.5);
x = x(:);
y = y(:);

%We then classify all points in this space
j = classify([x y],data(:,1:2),labels);

%And we can plot it to see the boundaries of each category. If we comment
%out the command "figure" it will plot it on top of our previous
%scatterplot, else we will see this as an independent plot
figure;
gscatter(x,y,j,'grb','sod')

%% Note that so far we have used all of our data for the classification
%analysis, but as we explained, one should instead take some data for
%training and test it in another set of data. This way we can get a more
%stable classification score and an idea of how well it will generalize to
%new datasets it has not encountered before. In order to do this we use
%crossvalidation. 

%First we create 10 random partitions of our data
cross_val_part = cvpartition(labels,'KFold',10);

%We can now estimate the true test error for our classification analysis
% using 10-fold stratified cross-validation. That is to say, we will
% iteratively go through each of these 10 partitions, run our linear classifier
% get an accuracy score for that classifier, and go to the next partition
% to repeat the process until we have gone through the 10 divisions of our data
cvlda = crossval(linear_class,'CVPartition',cross_val_part);

%The kfolds loss function will report the error rate of the classification
%analysis over folds
ldaCVErr = kfoldLoss(cvlda);
