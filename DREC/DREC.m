%% Obtain Z by RLRR

function Out = DREC(E,K,lambda)

% Input: E, base clustering
%        K, the number of clusters
%        lambda, regularization term

% find Microclusters
[newBaseCls, mClsLabels] = computeMicroclusters(E);
% Binary data matrix
BE = Gbe(newBaseCls);
Z = Robust_LearnZ(BE',lambda);

%post processing
[U,S,V] = svd(Z,'econ');
S = diag(S);
r = sum(S>1e-4*S(1));
U = U(:,1:r);S = S(1:r);
U = U*diag(sqrt(S));
U = normr(U);
L = (U*U').^4;

Blable = spectral_clustering(L, K);
Blable = mapMicroclustersBackToObjects(Blable,mClsLabels);
Out.Blable = Blable;