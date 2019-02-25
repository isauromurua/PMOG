function h = hermite(n, x)
    % Hermite polynomials.
    %   h = HERMITE(n,x)
    %   h is the nth Hermite polynomial evaluated at x.
    %   Usage with vectors is allowed.
    
    if isvector(x)
        
    elseif size(x,1)>1 && size(x,2) > 1 % Hay que cambiar esta condicion
        [size1, size2] = size(x);
        m = floor(n / 2);
        l = repmat(0:m, 1, 1, 1);
        l = permute(l, [1 3 2]);
        l = repmat(l, size1, size2, 1);
        x = repmat(x, 1, 1, m+1);
        h = factorial(n) .* sum(((-1).^l .* (2 .* x).^(n - 2 .* l)) ./ ...
            (factorial(l) .* factorial(n - 2 .* l)), 3);
        
    end
end