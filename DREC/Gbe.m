%% Generate Binary labeling matrix E

function BE = Gbe(E)
%==========================================================================
%
% Input: E: n*M matrix of clustering results, where n denotes the number of
% samples and M denotes the number of clusterings 
%
% Output: BE: n*KM, KM, is the total number of clusters;
%
%%========================================================================

[E, KM] = relabelCl(E); % re-labelling clusters in the ensemble E 
N = size(E,1); % no of data points
KM = max(max(E));
BE = zeros(N,KM); % matrix indicates if data point belongs to the cluster (1=y, 0=n), row=data, col = cluster
for i=1:N
    BE(i,E(i,:))=1; % pc(i,j) = 1 if data i belongs to cluster j
end