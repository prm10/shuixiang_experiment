%% 画图
function plotresult1(lumpda,deltaT,Np,g,g_k,delta1,delta2)
figure,plot(0:deltaT:deltaT*(Np-1),g,[0 70],[0 0]);
title(sprintf('1.连续系统相关分析法辨识结果,信噪比=%0.5f',lumpda/delta1));
axis([0 70 0 0.09]);grid;xlabel('时间/s');
figure,plot(deltaT:deltaT:deltaT*(Np-1),g_k,[0 70],[0 0]);
title(sprintf('2.离散系统相关分析法辨识结果,信噪比=%0.5f',lumpda/delta2));
axis([0 70 0 0.09]);grid;xlabel('时间/s');