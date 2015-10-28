function [J_L N theta2 t theta]=RLS(u,z,Np,yuzhi,n0)
L=Np;
n=1;
Theta=cell(0);
flag=0;
while n<=6
    %开始迭代
    new_theta2=zeros(2*n,1);p=1e20*eye(2*n);J_k=0;h=zeros(L,2*n);
    th1=zeros(2*n,L);
    for k=1:L
        h(k,1:n)=-z(Np+k-1:-1:Np+k-n);
        h(k,(n+1):2*n)=u(Np+k-1:-1:Np+k-n);
    end
    for k=1:L
        th1(:,k)=new_theta2;
        K=p*h(k,:)'*(1+h(k,:)*p*h(k,:)')^-1;
        new_theta2=new_theta2+K*(z(Np+k)-h(k,:)*new_theta2);
        J_k=J_k+(z(Np+k)-h(k,:)*new_theta2)^2/(1+h(k,:)*p*h(k,:)');
        p=p-K*K'*(1+h(k,:)*p*h(k,:)');
    end
    Theta=[Theta th1];
    J_L(n,1)=J_k/L;
    %迭代结束，得到J_L和theta
    if n~=1
        t(n-1)=(J_L(n-1,1)-J_L(n,1))/J_L(n,1)*(L-2*(n+1))/2;
        if t(n-1)>yuzhi && flag==0 && n0==0
            N=n-1;
        else
            if n==n0
                N=n0;
            end
            flag=1;
        end
    end
    n=n+1;
end
theta=Theta{N};
theta2=theta(:,length(theta(1,:)));