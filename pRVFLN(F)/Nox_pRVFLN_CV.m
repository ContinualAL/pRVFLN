
clc 

nrun=5;
nFolds=10;
[P1,T1]=normal(train(:,1:end-1),train(:,end));
[P2,T2]=normal(tes(:,1:end-1),tes(:,end));
Nox=[P1 T1;P2 T2];
cvData = crossValidate(Nox(:,1:end-1),Nox(:,end),nFolds);
    A1=[];
B=[];
C=[];
D=[];
E=[];
F=[];
for j=1:nrun

for i=1:nFolds
     Xall=cvData{i,1}';
    Yall=cvData{i,2}';
    P = [];
    T = [];
    
    for f=1:nFolds
        if (f~=i)
            P = [P cvData{f,1}'];
            T = [T cvData{f,2}'];
        end
    end
    P1=P';
T1=T';
P2=Xall';
T2=Yall';
Data=[P1 T1;P2 T2];

fix_the_model=size(P1,1);
ninput=170;
k1=0.35;
k2=0.02;
k3=0.002;
parameters(1)=k1;
parameters(2)=k2;
parameters(3)=k3;
subset=5;
mode='p';
[Center_upper,Center_lower,Spread_multivariate,sigmapoints,Tetak,time,rule,input,design_factor,y,dilation,translation,recurrent_link,recurrent_link1,count_samples,nrmse_fix] = pRVFLN(Data, fix_the_model,parameters,ninput,subset,mode);
nparameters=(2*subset+1)*rule(end);
A1(j,i)=nrmse_fix;
B(j,i)=rule(end);
C(j,i)=time;
D(j,i)=nparameters;
F(j,i)=count_samples;
end


end
Arat=mean(mean(A1));
Adev=std(std(A1));
Brat=mean(mean(B));
Bstd=std(std(B));
Crat=mean(mean(C));
Cdev=std(std(C));
Drat=mean(mean(D));
Ddev=std(std(D));
Frat=mean(mean(F));
Fdev=std(std(F));