% Asks how far wrong we'd be if we just took the mean confidence as our prediction. %
function [J] = costFunctionNaive(meanConfidence, y) 
% We add tiny tiny constants here, because otherwise any time a prediction of mean confidence 1 was wrong,
% or a prediction of mean confidence 0 was correct, we'd get infinite error.
J = ((-y'*log(meanConfidence + 0.00000000001))-(1-y')*log(1 - meanConfidence + 0.00000000001))/length(y);
end
