function [T] = execution(num)
switch num
   case 1
      load('BME01.mat')
   case 2
      load('BME02.mat')
   case 3
      load('BME03.mat')
   case 4
      load('BME04.mat')
   case 5
      load('BME05.mat')
   case 6
      load('BME06.mat')
   %case 7
    %  load('Sub7.mat')
   %case 8
    %  load('Sub8.mat')
   otherwise
      disp('Unknown Result')
end
[Train,Test]=crossvalind('HoldOut',y(:,1),0.35);
Xtrain=X((Train==1),:);
Xtest=X((Test==1),:);
ytrain=y((Train==1),:);
ytest=y((Test==1),:);

for i=1:50
svmstruct=svmtrain(Xtrain,ytrain(:,1),'Kernel_Function','rbf','RBF_Sigma',i);
class=svmclassify(svmstruct,Xtest);
x=classperf(class,ytest(:,1));
R(i)=x.CorrectRate;
end
[A,I]=max(R');

r=find(A==1);

ytraine=ismember(ytrain(:,2),100);
ytrainf=ismember(ytrain(:,2),200);
ytrains=ismember(ytrain(:,2),300);

yteste=ismember(ytest(:,2),100);
ytestf=ismember(ytest(:,2),200);
ytests=ismember(ytest(:,2),300);

svmstructe=svmtrain(Xtrain,ytraine,'Kernel_Function','rbf','RBF_Sigma',I);
cle=svmclassify(svmstructe,Xtest);

svmstructf=svmtrain(Xtrain,ytrainf,'Kernel_Function','rbf','RBF_Sigma',I);
clf=svmclassify(svmstructf,Xtest);

svmstructs=svmtrain(Xtrain,ytrains,'Kernel_Function','rbf','RBF_Sigma',I);
cls=svmclassify(svmstructs,Xtest);

for i=1:length(ytest)
    if cle(i,:)==1
        classefs(i,:)=100;
    end
        if clf(i,:)==1
            classefs(i,:)=200;
        end
            if cls(i,:)==1
                classefs(i,:)=300;
            end
end
    
cp=classperf([class,classefs],ytest);
Acc=cp.correctrate;

T=[class,classefs];

end
