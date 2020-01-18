
clc 

[P1,T1]=normal(train(:,1:end-1),train(:,end));
[P2,T2]=normal(tes(:,1:end-1),tes(:,end));
Nox=[P1 T1;P2 T2];

Data=Nox;
nruns=5;
A=[];B=[];C=[];D=[];E=[];
for l=1:nruns
fix_the_model=667;

ninput=170;
k1=0.39;
k2=0.02;
k3=0.002;
parameters(1)=k1;
parameters(2)=k2;
parameters(3)=k3;
subset=5;
mode='p';
[Center_upper,Center_lower,Spread_multivariate,sigmapoints,Tetak,time,rule,input,design_factor,y,dilation,translation,recurrent_link,recurrent_link1,count_samples,nrmse_fix,rmse_fix,ndei_fix,traceinputweight] = pRVFLN(Data, fix_the_model,parameters,ninput,subset,mode);
nparameters=(2*subset+1)*rule(end);

A(l)=rmse_fix;
B(l)=size(Center_upper,1);
C(l)=time;
D(l)=count_samples;
E(l)=nparameters;
end
Arat=mean((A));
Adev=std((A));
Brat=mean((B));
Bstd=std((B));
Crat=mean((C));
Cdev=std((C));
Drat=mean((D));
Ddev=std((D));
Erat=mean((E));
Edev=std((E));


