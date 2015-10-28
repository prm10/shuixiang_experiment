clear;close all;clc;
deltat=30;
data=importdata('data_d1_jieyue.csv',',');
t1=datenum(data.textdata);
v1=data.data;
data=importdata('data_s1_jieyue.csv',',');
t2=datenum(data.textdata);
v2=data.data;
figure,hold on;
for i1=1:length(t1)-1
    plot(t1(i1:i1+1),[v1(i1) v1(i1)],'b');
    plot([t1(i1+1) t1(i1+1)],v1(i1:i1+1),'b');
end
for i1=1:length(t2)-1
    plot(t2(i1:i1+1),[v2(i1) v2(i1)],'r');
    plot([t2(i1+1) t2(i1+1)],v2(i1:i1+1),'r');
end
plot([t2(1) t2(end)],[v2(459) v2(459)]);
% figure,hold on;
% for i1=1:length(t1)-1
%     plot(i1:i1+1,[v1(i1) v1(i1)],'b');
%     plot([(i1+1) (i1+1)],v1(i1:i1+1),'b');
% end
tmin=t1(1);%max([min(t1);min(t2)]);
tmax=min([max(t1);max(t2)]);
n=floor((tmax-tmin)*24*3600/deltat-1);
for i1=1:n
    t=tmin+i1*deltat/3600/24+5/3600/24;
    index=find(t1<t);
    input(i1,1)=v1(index(end));
    t=tmin+i1*deltat/3600/24;
    index=find(t2<t);
    output(i1,1)=v2(index(end));
end
% figure,hold on;
% for i1=1:length(input)-1
%     plot(i1:i1+1,[input(i1) input(i1)],'b');
%     plot([(i1+1) (i1+1)],input(i1:i1+1),'b');
% end
input=2*(input>mean(input))-1;
figure;
subplot(211);plot(input);
subplot(212);plot(output);

a_M=1;
Np_M=15;
L_M=length(input);
u_M=input;
y=output;

R_Mzk=zeros(Np_M-1,1);
for i=1:Np_M-1
    tempSum=0;
    for j=0:L_M-1
        if(j-i+1<=0)
            tempNp=Np_M;
        else
             tempNp=0;
        end
        tempSum=tempSum+u_M(j-i+1+tempNp)*y(j+1);
    end
    R_Mzk(i)=tempSum/L_M;
end
C=-1*R_Mzk(Np_M-1);
g_bar_hat=Np_M/((Np_M+1)*a_M^2)*(R_Mzk+C);
figure();plot([1:1:Np_M-1],g_bar_hat);xlabel('Ê±¼ä/s')
