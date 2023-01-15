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

% This code is used to solve the controller synthesis problem for multiple brains in parallel.

% This code is written by: Ilias Mitrai <mitra047@umn.edu>
% For any questions please contact: Prodromos Daoutidis <daout001@umn.edu>


% import data
brain_data = import data; % Note this should change before executing the code
% struct to store the results for all the brains
results = {};

% define options for LQRSP
% if the options change for different brains then add lines 10,12 inside the parfor loop
p_val = linspace(8.5,11,11); % feedback cost
% options for the LQRSP 
options = struct('method','card','gamval',p_val ,'rho',100,'maxiter',1000,'blksize',[1,1]);

% Number of brains that is analyzed is N_brains

% Note: The code below is a pseudocode it will raise errors
% You must substitute line 26

parfor i=1:N_brains
    A = get A matrix for index i;
    % the normalization is done in the analyze_functional_networks file
    % if the A is normalized then comment line 32 in the `analyze_functional_networks.m` file
    
    % solve the LQRSP problem
    [data]=analyze_functional_networks(A, options)
    
    % data is a struct with fields:
    %  data: is a struct with fields:
    %       data.F [size = n x n x len(gamval)] the optimal feedback gain matrix for different values of p
    %       data.nnz [size = len(gamval)] The number of nonzero entries in the F matrix for different values of p
    %       data.J [size = len(gamval)]   H2 norm for different values of p
    %       data.gam [size = len(gamval)] The values of the parameter p
    %       data.Fopt [size = n x n x len(gamval)] the solution of the structured problem # this is not used in the paper
    %       data.Jopt [size = len(gamval)] H2 norm of the structured problrm # not used in the paprer
    
    results{i} = data;
end

% The outout of the file is the results which is a nested struct data type.
% the first field is the brain index
% results(i) has the results for brain with index i
% results(i) is a struct with fields:
%   results(1).data.F [size = n x n x len(gamval)] the optimal feedback gain matrix for different values of p
%   results(1).data.nnz [size = len(gamval)] The number of nonzero entries in the F matrix for different values of p
%   results(1).data.J [size = len(gamval)]   H2 norm for different values of p
%   results(1).data.gam [size = len(gamval)] The values of the parameter p
%   results(1).data.Fopt [size = n x n x len(gamval)] the solution of the structured problem # this is not used in the paper
%   results(1).data.Jopt [size = len(gamval)] H2 norm of the structured problrm # not used in the paprer
    
