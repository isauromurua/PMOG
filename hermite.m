function h = hermite(n, x)
    % Hermite polynomials.
    %   h = HERMITE(n,x)
    %   h is the nth Hermite polynomial evaluated at x.
    %   Usage with vectors is allowed.
    
%     if isvector(x)
%         [size1, size2] = size(x);
%         m = floor(n / 2);
%         l = repmat(0:m, 1, 1, 1);
%         l = permute(l, [1 3 2]);
%         l = repmat(l, size1, size2, 1);
%         x = repmat(x, 1, 1, m+1);
%         h = factorial(n) .* sum(((-1).^l .* (2 .* x).^(n - 2 .* l)) ./ ...
%             (factorial(l) .* factorial(n - 2 .* l)), 3);
%     elseif not(isvector(x)) && ismatrix(x)
%         [size1, size2] = size(x);
%         m = floor(n / 2);
%         l = repmat(0:m, 1, 1, 1);
%         l = permute(l, [1 3 2]);
%         l = repmat(l, size1, size2, 1);
%         x = repmat(x, 1, 1, m+1);
%         h = factorial(n) .* sum(((-1).^l .* (2 .* x).^(n - 2 .* l)) ./ ...
%             (factorial(l) .* factorial(n - 2 .* l)), 3);
%         
%     end
    
    % Version recursiva sacada de Wolfram
    if n>2
        h = 2.*x.*hermite(n-1,x) - 2*n.*hermite(n-2,x); % Relacion recursiva
    elseif n==2
        h = 4.*x.^2 - 2; % H_2(x)
    elseif n==1
        h = 2.*x;
    elseif n == 0
        h = ones(size(x));
    else
        error("El numero n no es compatible")
    end
        
end