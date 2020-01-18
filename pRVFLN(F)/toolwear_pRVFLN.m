% test with the Box-Jenkins data

% clear 

nFolds=10;
nRun=5;

p3=cutter(:,1:end-1);
cvData = crossValidate(cutter(:,1:end-1),cutter(:,end),nFolds);
A1=[];
B=[];
C=[];
D=[];
E=[];
F=[];
for j=1:nRun
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
[r,q]=size(P);
fix_the_model=q;
[r1,q1]=size(Xall);

P1=P';
T1=T';
P2=Xall';
T2=Yall';
Data=[P1 T1;P2 T2];
ninput=12;
k1=0.2;
k2=0.02;
k3=0.002;
parameters(1)=k1;
parameters(2)=k2;
parameters(3)=k3;
subset=8;
mode='p';
[Center_upper,Center_lower,Spread_multivariate,sigmapoints,Tetak,time,rule,input,design_factor,y,dilation,translation,recurrent_link,recurrent_link1,count_samples,nrmse_fix,traceinputweight] = pRVFLN(Data, fix_the_model,parameters,ninput,subset,mode);
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



