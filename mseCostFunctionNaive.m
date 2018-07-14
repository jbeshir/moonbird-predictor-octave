function [J] = mseCostFunctionNaive(meanConfidence, y) 
J = sum((y-meanConfidence).^2)/length(y);
end
