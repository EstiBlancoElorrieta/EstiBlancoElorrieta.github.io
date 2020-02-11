% Purpose:      Provide sample script for traditional MDS analysis
% Input:        None
% Output:       MDS plot of US cities
% Dependencies:     none
% Version history:  02/10/2020
% Matlab version:   2015a
% Creator:  Esti Blanco-Elorrieta
%% Start a new script from scratch%

clear all; close all; clc


%% Create data for the simulation

% First, create the distance matrix and pass it to cmdscale. In this example,
% D is a full distance matrix: it is square and symmetric, 
% has positive entries off the diagonal, and has zeros on the diagonal.

%First we create a vector with the city names we will be doing our simulation
% with
cities = {'Atl','Chi','Den','Hou','LA','Mia','NYC','SF','Sea','DC'};

% Then we create a distance matrix with the miles between this cities
% distances have been taken from www.distancebetweencities.us
D = [    0  587 1212  701 1936  604  748 2139 2182   543;
       587    0  920  940 1745 1188  713 1858 1737   597;
      1212  920    0  879  831 1726 1631  949 1021  1494;
       701  940  879    0 1374  968 1420 1645 1891  1220;
      1936 1745  831 1374    0 2339 2451  347  959  2300;
       604 1188 1726  968 2339    0 1092 2594 2734   923;
       748  713 1631 1420 2451 1092    0 2571 2408   205;
      2139 1858  949 1645  347 2594 2571    0  678  2442;
      2182 1737 1021 1891  959 2734 2408  678    0  2329;
       543  597 1494 1220 2300  923  205 2442 2329     0];
   
 %% Next we apply multidimensional scaling onto these data
 
 [Y,eigvals] = cmdscale(D); 
 
 
 %% Plot in space to see that it represents the spatial distribution 
 % of these points faithfully. Note that our plotting of north up and south
 % done is a convention, hence, although the MDS solution will represent 
 % the distances between cities faithfully, it is possible that the axes 
 % will be unconventional (i.e., north and south may be reversed)
 
plot(Y(:,1),Y(:,2),'.')
text(Y(:,1)+25,Y(:,2),cities)
xlabel('Miles')
ylabel('Miles')

%% Plot as heatmap and dendrogram to see the difference in information provided by graph

%Heatmap
figure;
imagesc(D)
set(gca,'XTickLabels',{'Atl','Chi','Den','Hou','LA','Mia','NYC','SF','Sea','DC'}, 'YTickLabels',{'Atl','Chi','Den','Hou','LA','Mia','NYC','SF','Sea','DC'}, 'fontsize',12)
colorbar

%Dendrogram
figure;

% We need to use the linkage function, to join observations into clusters.
% This function takes the distance information and links pairs of objects 
% that are close together into binary clusters.
% The linkage function then links these newly formed clusters to each other
% and to other objects to create bigger clusters until all the objects in 
% the original data set are linked together in a hierarchical tree.
data = linkage(D);

% Create the dendrogram
dendrogram(data, 'Labels',{'Atl','Chi','Den','Hou','LA','Mia','NYC','SF','Sea','DC'})

