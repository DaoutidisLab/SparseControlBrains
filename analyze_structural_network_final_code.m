% Hello there!
% This code was used in this publication:
% 
%  Mitrai, I., Jones, V., Dewantoro, H., Stamoulis, C., Daoutidis P., Internal 
%  control of brain networks via Sparse feedback, submitted to AIChE Journal
%  
% If you use this code please cite:
% 
% @article{mitrai2020internal,
%   title={Internal Control of Brain Networks via Sparse Feedback},
%   author={Mitria, Ilias and Jones, Victoria and  Dewantoro, Harman and Stamoulis, Caterina and Daoutidis, Prodromos},
%   journal={under review},
%   volume={},
%   pages={},
%   year={2023},
%   publisher={}
% }

% This code solves a sparsity promoting optimal control problem for 
% structural brain networks

%% analyze all brains
% load the data
load('NCTfMRI30SubScale60_ROI_volcorrected.mat')
n=129; % number of nodes in the networks
all_data = {} % store results for all runs

parfor kk=1:30 % loop over all brains -- if parfor is not avaialbe use for
    disp(kk)
    A = squeeze(X_ROI_volscaled(kk,:,:));
    % normalize A
    A = (A- diag(diag(A)))/(max(eig(A))+1) - eye(n);
    % options for LQRSP
    options = struct('method','card','gamval',logspace(-6,0,5),'rho',100,'maxiter',1000,'blksize',[1]);
    tic
    % solve the LQRSP problem
    solpath = lqrsp(A,eye(n),eye(n),eye(n),eye(n),options);
    toc
    % store the results
    all_data(kk) = solpath;
end
