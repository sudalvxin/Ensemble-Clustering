%% Generate clustering results with varying K
%% select datasets
function Out = LoadTestE2(Dnum,M)
% Input: Dnum: data's num
%        M, the number of clusterings 
% Output: Out.E:  matrix of cluster ensemble
%         Out.gt: the groundtruth
%         Out.BE: kM*n matrix of cluster results with binary, each column can be considered as a new feature of sample. 
%         Out.CAM: n*n the co-association matrix
addpath 'GG:\ClusterEnsemble\PR-2018\Data2'    % n<1000
Files = dir(fullfile('G:\ClusterEnsemble\PR-2018\Data2', '*.mat'));
% 
Dname = Files(Dnum).name;
disp(['The test data and E is:' Dname])
load(Dname,'members','gt');
E = members;
randind = randperm(100);
Bind = randind(1:M); % The indices of base clusterings
%
EC = E(:,Bind);
% 
Out.E = EC;
BE = Gbe(EC);
Out.BE = BE';
Out.CAM = computeMCA(EC);
Bigraph = formBi(EC);
Out.Bigraph = Bigraph;
realLabel = gt;
Out.gt = realLabel;

