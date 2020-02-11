% Purpose:      Provide sample script for K-means clustering
% Input:        None
% Output:       Three plots. 1) Original data 2) Two original clusters 3)
%               Result of clustering algorithm for contrast with true data
% Dependencies:     none
% Version history:  02/10/2020
% Matlab version:   2015a
% Creator:  Esti Blanco-Elorrieta

%% Start a new script from scratch%

clear all; close all; clc


%% Create simulation data 

%Create some gaussian distributed random variables. Let's pretend these 
% data comes from some type of data, let's say cats.

%We make a variable, that is randomly distributed following a gaussian 
%distribution with mean 0, and 1 variance. One column, 240 rows
x = randn(240,1);

% We make a similarly random variable but we narrow the variance
y = 0.5*randn(240,1);

%We can plot them to see their configuration in space. This figure shows 
% our random distribution of points
plot(x,y,'ko','Linewidth',[2])

%Now we will create similarly randomly distributed data for e.g. dogs, and
%we will center this data around 1 and -1, instead of 0.

x2 = randn(240,1)+2;
y2 = 0.2*randn(240,1)-2;

%We can now see how these two groups are different in space
%plot cats in black
figure;
plot(x,y,'ro','Linewidth',[2]); hold on;
%plot dogs in red
plot(x2,y2,'bo','Linewidth',[2])

%This is the data set we are going to try to sort out. Most red dots are
%up, and most blue dots are down. 

%Join the vectors in one. Although we know that the data is coming from two
%distinct clusters, we will feed it as one to test that the algorithm works
xjoined = [x; x2]
yjoined = [y; y2]

%add x and y columns in one matrix
joined = [xjoined yjoined]

%% Run k-means clustering algorithm

%We run k-means clustering on the joined data and let the algorithm split
%it meaningfully for us. The variable "idx" will contain the index of the
%centroid each observation was asigned to (either group 1 or group 2). Variable "C"
%will contain the coordinates for each of the two centroids

[idx,C] = kmeans(joined,2);

%% We plot the data to check that the algorithm has done its job correctly

%Open a new figure
figure;

%We will plot the observations that were asigned to group 1 first in red by
%selecting idx == 1
plot(joined(idx==1,1),joined(idx==1,2),'r.','MarkerSize',12)
hold on

%We will plot the observations that were asigned to group 2 in black by
%selecting idx == 2
plot(joined(idx==2,1),joined(idx==2,2),'b.','MarkerSize',12)

%We plot the centroids of each of the two clusters
plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3) 

%Add a legend and a title
legend('Cluster 1','Cluster 2','Centroids','Location','NW')
title 'Cluster Assignments and Centroids'

%We are done, now we can compare the original figure before we mixed our 
%data together, and the way k-means algorithm has sorted it out
hold off