function ML1 =LLFun(x,dat)
beta = x(1); mu = x(2); sigma = x(3);
M = dat;
n = length(M);
ML = n*log(beta) + n*beta*mu - n/2*beta*beta*sigma*sigma;% ��Mi�޹ز���
for i = 1:n
    ML = ML -(beta*M(i)-log(normcdf(M(i),mu,sigma)));% normcdf ��̬�ֲ��ķֲ�����
end
ML1 = - ML; %��Ϊfmin������С�������ҵ��������Ȼ���ƣ���������Ӹ��� - 
