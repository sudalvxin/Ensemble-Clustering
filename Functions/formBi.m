%% Gnerate the bigraph

function Bigraph = formBi(E)
% this function turns a cluster ensemble into a set of new binary features, one for each cluster
% if the object belongs to that cluster, the value is set to 1, and 0 otherwise
% Input: E, instnum*r, where instnum is the number of samples, and r is the
% number of clusterings;
[instnum,r] = size(E);
site=1;
for i=1:r
  idx = E(:,i);
  uniqueks=unique(idx(idx>0)); % 0 is considered to be the unclustered 
  t=zeros(instnum, length(uniqueks));
  t(find(repmat(idx, 1, length(uniqueks)) == repmat(uniqueks', instnum, 1)))=1;
  w(:, site:site+length(uniqueks)-1) = t;
  site=site+length(uniqueks);
end
Bigraph  = w;