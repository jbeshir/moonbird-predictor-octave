function permutatedX = permutateFeatures(normalizedUnmappedX, maxDegree)
	permutations = cell(0);
	permutationDegrees = cell(0);
	pEnd = 0;
	for countElem = 1:size(normalizedUnmappedX, 2)
		permutation = linspace(1,countElem, countElem);
		permutationDegree = ones(countElem, 1);
		while true
			if countElem > 1 || permutationDegree != 1
				permutations{pEnd+1} = permutation;
				permutationDegrees{pEnd+1} = permutationDegree;
				pEnd = pEnd + 1;
			end
			
			incremented = 0;
			for slot = countElem:-1:1
				if permutationDegree(slot) < maxDegree
					permutationDegree(slot) = permutationDegree(slot) + 1;
					if slot < countElem
						permutationDegree(slot+1:countElem) = ones(countElem-slot, 1);
					end
					incremented = 1;
					break
				end	
			end
			if incremented == 1
				continue
			end
			
			for slot = countElem:-1:1
				if permutation(slot) < size(normalizedUnmappedX, 2)-countElem+slot
					permutation(slot) = permutation(slot) + 1;
					if slot < countElem
						permutation(slot+1:countElem) = linspace(permutation(slot)+1,permutation(slot)+countElem-slot,countElem-slot);
					end
					permutationDegree = ones(countElem, 1);
					incremented = 1;
					break
				end	
			end
			if incremented == 1
				continue
			end
			
			break
		end
	end
	
	permutatedX = normalizedUnmappedX;
	for i = 1:pEnd
		perm = permutations{i};
		permDegree = permutationDegrees{i};
		permColumn = normalizedUnmappedX(:, perm(1)) .^ permDegree(1);
		for slot = 2:size(perm, 2)
			permColumn = permColumn .* (normalizedUnmappedX(:, perm(slot)) .^ permDegree(slot));
		end
		permutatedX = [permutatedX, permColumn];
	end
end