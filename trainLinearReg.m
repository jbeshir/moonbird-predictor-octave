function [theta] = trainLinearReg(X, y, lambda)
%TRAINLINEARREG Trains linear regression given a dataset (X, y) and a
%regularization parameter lambda
%   [theta] = TRAINLINEARREG (X, y, lambda) trains linear regression using
%   the dataset (X, y) and regularization parameter lambda. Returns the
%   trained parameters theta.
%

% Initialize Theta
initial_theta = zeros(size(X, 2), 1); 

% Create "short hand" for the cost function to be minimized
costFunction = @(t) costFunctionReg(t, X, y, lambda);

% Now, costFunction is a function that takes in only one argument
options = optimset('MaxIter', 20000, 'GradObj', 'on');

% Minimize using fminunc
theta = fminunc(costFunction, initial_theta, options);

end
