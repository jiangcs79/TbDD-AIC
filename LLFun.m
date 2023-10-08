function ML1 =LLFun(x,dat)
beta = x(1); mu = x(2); sigma = x(3);
M = dat;
n = length(M);
ML = n*log(beta) + n*beta*mu - n/2*beta*beta*sigma*sigma;% 与Mi无关部分
for i = 1:n
    ML = ML -(beta*M(i)-log(normcdf(M(i),mu,sigma)));% normcdf 正态分布的分布函数
end
ML1 = - ML; %因为fmin是求最小，我们找的是最大似然估计，所以这里加负号 - 
