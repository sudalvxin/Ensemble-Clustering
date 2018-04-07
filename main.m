%% Parameter selection
clear all;
close all;
clc; 
addpath 'G:\ClusterEnsemble\PR-2018\Functions'  % your path
addpath  G:\ClusterEnsemble\PR-2018\DREC 
%% Settings
% Ensemble size M
M = 20; 
%% Generate various graphs 
datanum = 1;  % the index of test data  
disp(['The data number is:' num2str(datanum)])
%% generate base clusterings 
Di = 1; % Data1
if Di==1
OutE = LoadTestE(datanum,M);   % 25/18/2/4
else
OutE = LoadTestE2(datanum,M);
end
E = OutE.E; 
BE = OutE.BE;
C = OutE.CAM;
Bigraph = OutE.Bigraph;
truelabels = OutE.gt;
K = max(truelabels);
Out.cluster = K;
%% Test algorithms
disp('The performance is measured by ACC, NMI and Purity respectively')  

%% Test K-means
K_NMI = [];
for i=1:M
    result = ClusteringMeasure(truelabels, E(:,i));
    K_NMI(i,:) = result;
end
MeanK = mean(K_NMI);
MaxK = max(K_NMI);
MinK = min(K_NMI);
Out.MeanK = MeanK;
Out.MaxK = MaxK;
Out.MinK = MinK;
%% parameter set
lambdaS = [1e-3,1e-2 1e-1 1 10 100 1000];
for ls = 1:length(lambdaS)
   lambda = lambdaS(ls);
   disp('***********************************Test our method DREC*********************************')
   OutD = DREC(E,K,lambda);
   ESDN_ids = OutD.Blable;
   rECDR(ls,:) = ClusteringMeasure(truelabels, ESDN_ids);
end    
Out.rECDR = rECDR;

% Plot
x = lambdaS;

measure = 2; % ACC, 2, NMI, 3,Purity

y1 = MeanK(measure)*ones(length(x),1);
y2 = MaxK(measure)*ones(length(x),1);
y3 = MinK(measure)*ones(length(x),1);
y4 = rECDR(:,measure);
h = semilogx(x,y1,x,y2,x,y3,x,y4,'*-');
set(h,'LineWidth',2.0);
s = gca;
set(s, 'Fontname', 'Times new roman','FontSize',16); 
set(gca,'linewidth',1.5); 
if measure ==1
hl = legend('Mean-ACC', 'Max-ACC','Min-ACC','DREC-ACC');
xlabel('The value of regularization parameter');
ylabel('ACC');
else
hl = legend('Mean-NMI', 'Max-NMI','Min-NMI','DREC-NMI'); 
xlabel('The value of regularization parameter');
ylabel('NMI');
end
set(hl,'Orientation','vertical','FontSize',14);
ymin = min(y4);
ymax = max(y4);
axis([min(lambdaS) max(lambdaS) min(ymin,MinK(measure))-0.1 max(ymax,MaxK(measure))+0.1]) 

