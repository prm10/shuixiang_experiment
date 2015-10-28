function [J_L ,N ,theta1 ,t ,z_p]=Ls(u_M,z,Np,yuzhi,n0)
L=Np;
% x=3;
z_L=z(Np+1:Np+L)';
n=1;
t(n)=0;
N=1;
flag=0;
while n<=6
    h=zeros(L,2*n);
    for k=1:L
        h(k,1:n)=-z(Np+k-1:-1:Np+k-n);
        h(k,(n+1):2*n)=u_M(Np+k-1:-1:Np+k-n);
    end
    new_theta1=(h'*h)\(h'*z_L);
    J_L(n,1)=1/L*sum((z_L-h*new_theta1).^2);
    if n~=1
        t(n-1)=(J_L(n-1,1)-J_L(n,1))/J_L(n,1)*(L-2*(n+1))/2;
        if t(n-1)>yuzhi && flag==0 && n0==0
            theta1=theta0;
            N=n-1;
        else
            if n==n0
                N=n0;
                theta1=new_theta1;
            end
            flag=1;
        end
    else
        theta1=new_theta1;
    end
    theta0=new_theta1;
    n=n+1;
end
%% ¸ø³öÔ¤²âÇúÏßz_p
n=N;
h=zeros(L,2*n);
for k=1:L
    h(k,1:n)=-z(Np+k-1:-1:Np+k-n);
    h(k,(n+1):2*n)=u_M(Np+k-1:-1:Np+k-n);
end
z_p=h*theta1;