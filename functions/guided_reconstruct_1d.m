function [r, a, b, p] = guided_reconstruct_1d(g, gx, wx, sigma_s, epsi)

ss = sigma_s;

p = g;
cgx = cumsum(gx, 2);
p(:, 2:end, :) = bsxfun(@plus, p(:, 1, :), cgx(:, 1:end-1, :));

q = g;

mean_w = wx.^2; 
mean_p = boxfilter1d(p, ss);
mean_pq = boxfilter1d(p.*q, ss);
mean_q = boxfilter1d(q, ss);

cov_pq = max(0, mean_pq - mean_p.*mean_q);
mean_p2 = boxfilter1d(p.*p, ss);

var_p = max(0, mean_p2 - mean_p.^2);

epsi = epsi .* mean_w;

a = cov_pq ./ (var_p + epsi);
max_a = min(1, max(a, [], 3));
max_a = repmat(max_a, [1, 1, size(g, 3)]);
a = max(max_a, a);


b = mean_q - a.*mean_p;

mean_a = boxfilter1d(a, ss);
mean_b = boxfilter1d(b, ss);


r = mean_a.*p + mean_b;

end
