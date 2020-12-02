clc; clear all;

mono = textread('C:\Users\yujr9\Desktop\里程计原值.txt');

Time1 = mono(1,1);

t1(1,:) = mono(1,2:4); t1 = t1';
q1(1,:) = [mono(1,8), mono(1,5), mono(1,6), mono(1,7)];
q1 = quatnormalize(q1);
R1 = quat2dcm(q1);

R1 = inv(R1);
t1 = -R1*t1;

fid = fopen('Encoder.txt','wt');
for i = 1:length(mono)
    time = mono(i,1);
    timenew = time - Time1;
    q = [mono(i,8), mono(i,5), mono(i,6), mono(i,7)];
    q = quatnormalize(q);
    R = quat2dcm(q);
    t = mono(i,2:4); t = t';
    Rnew = R1*R;
    tnew = R1*t + t1;
    qnew = dcm2quat(Rnew);
    
    fprintf(fid,'%.7f\t',timenew);
    fprintf(fid,'%.7f\t',tnew(1));
    fprintf(fid,'%.7f\t',tnew(2));
    fprintf(fid,'%.7f\t',tnew(3));
    fprintf(fid,'%.7f\t',qnew(2));
    fprintf(fid,'%.7f\t',qnew(3));
    fprintf(fid,'%.7f\t',qnew(4));
    fprintf(fid,'%.7f\n',qnew(1));
end