function h = hermite(n, x)
    % Returns the nth Hermite polynomial evaluated at x
    [size1, size2] = size(x);
    m = floor(n / 2);
    l = repmat(0:m, 1, 1, 1);
    l = permute(l, [1 3 2]);
    l = repmat(l, size1, size2, 1);
    x = repmat(x, 1, 1, m+1);
    h = factorial(n) .* sum(((-1).^l .* (2 .* x).^(n - 2 .* l)) ./ ...
        (factorial(l) .* factorial(n - 2 .* l)), 3);
end