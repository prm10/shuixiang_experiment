function plotresult(Np,J_L1,J_L2,t1,t2,z,z_p,theta)
i=1:Np;
figure,
subplot(1,2,1);plot(1:length(J_L1),J_L1,'-*');title('LS�в��');
subplot(1,2,2);plot(1:length(t1),t1,'-*');title('LSͳ����t');
figure,
subplot(1,2,1);plot(1:length(J_L2),J_L2,'-*');title('RLS�в��');
subplot(1,2,2);plot(1:length(t2),t2,'-*');title('RLSͳ����t');
figure,plot(i,z(i+Np),'b',i,z_p,'r');title('ʵ��������Ԥ������');legend('ʵ������','Ԥ������');
figure,plot(1:Np,theta);title('������С���˵Ĳ�����ʶ');