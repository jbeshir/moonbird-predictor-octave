function p = assignProb(theta, mapper, X)
p = sigmoid(mapper(X)*theta)
end
