function glp = laguerg(a, n, x)
    % Returns the generalized Laguerre Polynomials valued at x,
    %   given constants a and n: 
    %   L_n^a(x) = sum_{i=0}^n((-1)^i nCr(n+a, n-i) x^i/i!)
    [taman1,taman2] = size(x);
    
    if size(x,2) == 1 || size(x,1) == 1
        X = repmat(x,1);
    elseif size(x,1)>1 && size(x,2) > 1
        X = repmat(x,1,1,n+1);
        index = permute(repmat((0:n)',1,taman1,taman2),[3 2 1]); % Summation index
        combinations = nCk(n + a, n - index); % Binomial coefficient for each term
        glp = sum((-1) .^ index .* combinations .* X .^ index ./ factorial(index),3);
    elseif ndims(x) == 3
        X = repmat(x,1,1,1,n+1);
        % Aqui van mas cosas
    end
end

function nk = nCk(n, k)
    % Vectorized version of nchoosek()
    nk = factorial(n) ./ (factorial(k) .* factorial(n - k));
end
