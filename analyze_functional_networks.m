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

function [data]=analyze_functional_networks(A, options)
    % The input is the adjacency matrix A and the options for the LQRSP problem
    % The output is a struct file with the results
    
    n,n = size(A);

    % normalize the A matrix -- if the A matrix is already normalized then comment the next line
    A = (A-diag(diag(A)))/(max(eig(A))+1) - eye(n); 
    % solve the LQRSP problem
    solpath = lqrsp(A,eye(n),eye(n),eye(n),eye(n),options)   % A is the adjacency matrix
    % store the results
    data = solpath;
    
    % the data file is a struct with fields:
    % 
    %       data.F [size = n x n x len(gamval)] the optimal feedback gain matrix for different values of p
    %       data.nnz [size = len(gamval)] The number of nonzero entries in the F matrix for different values of p
    %       data.J [size = len(gamval)]   H2 norm for different values of p
    %       data.gam [size = len(gamval)] The values of the parameter p
    %       data.Fopt [size = n x n x len(gamval)] the solution of the structured problem # this is not used in the paper
    %       data.Jopt [size = len(gamval)] H2 norm of the structured problrm # not used in the paprer
  
end

