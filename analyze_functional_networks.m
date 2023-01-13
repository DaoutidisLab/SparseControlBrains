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
% functional brain networks

% This code is written by: Harman Dewantoro <dewan055@umn.edu>
% For any questions please contact: Prodromos Daoutidis <daout001@umn.edu>

%% analyze all brains
% number of nodes in the network
% first import the data 
function [data]=K_gen_node_level(A)
    % The input is the adjacency matrix
    % The output is a struct file with the results
    
    n,n = size(A);

    % normalize the A matrix
    A = (A-diag(diag(A)))/(max(eig(A))+1) - eye(n); 

    % range of the penalty parameter 
    p_val=linspace(8.5,11,11);
    
    options = struct('method','card','gamval',p_val ,'rho',100,'maxiter',1000,'blksize',[1,1]);
    tic
    solpath = lqrsp(A,eye(n),eye(n),eye(n),eye(n),options)   % A is the adjacency matrix
    toc
    % store the results
    data.A = A;
    data.sol = solpath;
    
    % the data file is a struct with fields:
    % A: the adjacency matrix of the functional network
    % sol: is a struct with fields:
    %       F [size = n x n x len(gamval)] the optimal feedback gain matrix for different values of p
    %       nnz [size = len(gamval)] The number of nonzero entries in the F matrix for different values of p
    %       J [size = len(gamval)]   H2 norm for different values of p
    %       gam [size = len(gamval)] The values of the parameter p
    %       Fopt [size = n x n x len(gamval)] the solution of the structured problem # this is not used in the paper
    %       Jopt [size = len(gamval)] H2 norm of the structured problrm # not used in the paprer
  
end

