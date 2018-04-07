%% Compute the co-association matrix.

function S = computeMCA(baseCls)

% Input: baseCls: n*M, n is the number of samples, M is the number of
% clusterings
% Output: S: n*n, co-association matrix

[n, nBC] = size(baseCls);
cntCol = max(baseCls);

S = zeros(n,n);
for k = 1:nBC
    for idx = 1:cntCol(k)
        tmp1 = baseCls(:,k)==idx;
        tmp2 = 1:n;
        tmp = tmp2(tmp1); clear tmp1 tmp2
        
        for idxTmp = 1:numel(tmp)
            S(tmp(idxTmp), tmp) = S(tmp(idxTmp), tmp) + 1;
        end
    end
end
S = S*1.0/nBC;