%% ��ͼ
function plotresult1(lumpda,deltaT,Np,g,g_k,delta1,delta2)
figure,plot(0:deltaT:deltaT*(Np-1),g,[0 70],[0 0]);
title(sprintf('1.����ϵͳ��ط�������ʶ���,�����=%0.5f',lumpda/delta1));
axis([0 70 0 0.09]);grid;xlabel('ʱ��/s');
figure,plot(deltaT:deltaT:deltaT*(Np-1),g_k,[0 70],[0 0]);
title(sprintf('2.��ɢϵͳ��ط�������ʶ���,�����=%0.5f',lumpda/delta2));
axis([0 70 0 0.09]);grid;xlabel('ʱ��/s');