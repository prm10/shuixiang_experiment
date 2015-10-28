function delta=zhibiao(theta0,theta1,N1)
delta(1,1)=sqrt(sum(((theta1-theta0)./theta0).^2));
delta(1,2)=sqrt(sum((theta1-theta0).^2)/sum(theta0.^2));
K=sum(theta0(N1+1:2*N1,1))/(1+sum(theta0(1:N1,1)));
K1=sum(theta1(N1+1:2*N1,1))/(1+sum(theta1(1:N1,1)));
delta(1,3)=sqrt((K1-K)/K);