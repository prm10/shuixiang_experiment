function [seq]=mseq(connections,registers,len,a)
%***************************************************
% �˺�������������󳤶�������λ�Ĵ�������
% connectionsΪ��������ʽ������registersΪ��ʼֵ����
% lenΪ�������г��ȣ���Ϊ0�����һ������
% aΪ��ֵ
%***************************************************
m=length(connections);
L=2^m-1;     %���ڳ���
if len==0
    len=L;
end
fan=0;
seq= false(len,1);
for i=1:len
    %�������
    for j=1:m
        fan=fan +connections(j)*registers(j);
        fan=(mod(fan,2));
    end
    %�Ĵ�����λ
    registers(2:m)=registers(1:m-1);
    registers(1)=fan;
    seq(i)=logical(fan);
    fan=0;
end
seq=(seq*2-1)*a;