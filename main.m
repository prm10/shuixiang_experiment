clear;close all;clc;
data=importdata('data_d1_15s.csv',',');
t1=datenum(data.textdata);
v1=data.data;
data=importdata('data_s1_15s.csv',',');
t2=datenum(data.textdata);
v2=data.data;
plot(t1,v1,t2,v2);