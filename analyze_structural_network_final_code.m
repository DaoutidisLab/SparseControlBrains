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
%   author={Mitrai, Ilias and Jones, Victoria and  Dewantoro, Harman and Stamoulis, Catherine and Daoutidis, Prodromos},
%   journal={under review},
%   volume={},
%   pages={},
%   year={2023},
%   publisher={}
% }

% This code solves a sparsity promoting optimal control problem for 
% structural brain networks

% This code is written by: Ilias Mitrai <mitra047@umn.edu>
% For any questions please contact: Prodromos Daoutidis <daout001@umn.edu>

% load the data
load('NCTfMRI30SubScale60_ROI_volcorrected.mat')
n=129; % number of nodes in the networks
all_data = {} % store results for all runs

% set the parameters for the LQRSP problem

p_low = -6; # lower values of the penalty parameter Note: the discretization is in logspace
p_high = 0; # Upper values of the penalty parameter Note: the discretization is in logspace
Npts = 5;   # Number of discretization points of the penalty parameter

gam_val = logspace(p_low, p_high,Npts) % values of the penalty cost
# Options for LQRSP
options = struct('method','card','gamval',gam_val,'rho',100,'maxiter',1000,'blksize',[1]);


parfor kk=1:30 % loop over all brains -- if parfor is not available use for
    disp(kk)
    % get the A matrix 
    A = squeeze(X_ROI_volscaled(kk,:,:));
    % normalize A
    A = (A- diag(diag(A)))/(max(eig(A))+1) - eye(n);

    % solve the LQRSP problem
    solpath = lqrsp(A,eye(n),eye(n),eye(n),eye(n),options);
    % store the results
    all_data(kk) = solpath;
    
    % solpath is a struct with fields:
    %       F [size = n x n x len(gamval)] the optimal feedback gain matrix for different values of p
    %       nnz [size = len(gamval)] The number of nonzero entries in the F matrix for different values of p
    %       J [size = len(gamval)]   H2 norm for different values of p
    %       gam [size = len(gamval)] The values of the parameter p
    %       Fopt [size = n x n x len(gamval)] the solution of the structured problem # this is not used in the paper
    %       Jopt [size = len(gamval)] H2 norm of the structured problem # not used in the paprer
end
