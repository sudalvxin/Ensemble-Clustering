%% Generate clustering results 
%% select datasets
function Out = LoadTestE(Dnum,M)
% Input: Dnum: data's num
%        M, the number of clusterings 
% Output: Out.E:  matrix of cluster ensemble
%         Out.gt: the groundtruth
%         Out.BE: kM*n matrix of cluster results with binary, each column can be considered as a new feature of sample. 
%         Out.CAM: n*n the co-association matrix
addpath 'G:\ClusterEnsemble\PR-2018\OriginalData'    % n<1000
Files = dir(fullfile('G:\ClusterEnsemble\PR-2018\OriginalData', '*.mat'));
% 
Dname = Files(Dnum).name;
disp(['The test data and E is:' Dname])
load(Dname);
X = full(X);
X(:,find(sum(abs(X),1)==0))=[];
Data = X;
% ¹éÒ»»¯
[a] = max(Data);
[n,dim] = size(Data);
Data = Data./(ones(n,1)*a);
%
gt = Y;

disp(['**The number of data points is:' num2str(n)])
disp(['**The dimension of instance is:' num2str(dim)])
disp(['*******The number of  cluster is::' num2str(max(gt))])

% Generate
addpath 'G:\ClusterEnsemble\PR-2018\Data1'
load(Dname);
%
randind = randperm(100);
Bind = randind(1:M); % The indices of base clusterings
%
EC = E(:,Bind);
% 
Out.E = EC;
BE = Gbe(E);
Out.BE = BE';
Out.CAM = computeMCA(E);
Bigraph = formBi(E);
Out.Bigraph = Bigraph;
Out.gt = gt;
Out.data = Data;

