
function distibuteDataPerThreads(nThreads::Int64, nCells::Int64 )::Array{Int64,2}

	cellsThreads = zeros(Int64,nThreads,2);
 
 	if (nThreads>1)
		
    	nParts = floor(nCells/nThreads);

	    for i=1:nThreads
    		cellsThreads[i,2] =  nCells - nParts*(nThreads-i );
		end
	
    	for i=1:nThreads
      		cellsThreads[i,1] =  cellsThreads[i,2] - nParts + 1;
		end

    	cellsThreads[1,1] = 1;
		
	end
	
	return cellsThreads;

end