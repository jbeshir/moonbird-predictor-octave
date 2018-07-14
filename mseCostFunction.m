function [J] = mseCostFunction(theta, X, y) 
J = sum((y-sigmoid(X*theta)).^2)/length(y);
end
