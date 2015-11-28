function plotresult(Np,J_L1,J_L2,t1,t2,z,z_p,theta)
i=1:Np;
figure,
subplot(1,2,1);plot(1:length(J_L1),J_L1,'-*');title('LS残差方差');
subplot(1,2,2);plot(1:length(t1),t1,'-*');title('LS统计量t');
figure,
subplot(1,2,1);plot(1:length(J_L2),J_L2,'-*');title('RLS残差方差');
subplot(1,2,2);plot(1:length(t2),t2,'-*');title('RLS统计量t');
figure,plot(i,z(i+Np),'b',i,z_p,'r');title('实测曲线与预测曲线');legend('实测曲线','预测曲线');
figure,plot(1:Np,theta);title('递推最小二乘的参数辨识');