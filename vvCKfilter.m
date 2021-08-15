%%%%%%%%%%%
% function X=CKfilter(Y)
% vv=vv';
% tt=tt';
close all;
clear
numtotal=[];
files=dir('I:\PAO1_rest\MT21\*.mat');
for i=1:length(files)
    name=files(i).name;
    num=str2num(name(1:end-4));
    numtotal=[numtotal;num];
    clear name
end
for ii=1:length(files)
numtotal=sort(numtotal,1);
load(['I:\PAO1_rest\MT21\' num2str(numtotal(ii)) '.mat']);
name=[ num2str(numtotal(ii)) ];
Y=vv;
Y(find(isnan(Y)))=0;
%100 500 1000 2000
% L=[10 50 100 200];P=1/(2*length(L));p=-50;
L=[100 500 1000];P=1/(2*length(L));p=-50;
xf=zeros(length(L),length(Y));
xb=zeros(length(L),length(Y));
forward=zeros(length(L),length(Y));
backward=zeros(length(L),length(Y));
for i=1:length(Y)
    for k=1:length(L)
        if i<L(k)+1
%             xf(k,i)=0;
             xf(k,i)=sum(Y(i+1:i+L(k)))/L(k);
            xb(k,i)=sum(Y(i+1:i+L(k)))/L(k);
        elseif (length(Y)-i-1)<L(k)
            xf(k,i)=sum(Y(i-L(k):i-1))/L(k);
%             xb(k,i)=0; 
           xb(k,i)=sum(Y(i-L(k):i-1))/L(k);
        else
            xf(k,i)=sum(Y(i-L(k):i-1))/L(k);
            xb(k,i)=sum(Y(i+1:i+L(k)))/L(k);
        end
    end
end

for i=1:length(Y)
    for k=1:length(L)       
        if i<L(k)+1
            forward(k,i)=P*(sum((Y(1:i)-xf(k,1:i)').^2))^p;
            backward(k,i)=P*(sum((Y(i:i+L(k)-1)-xb(k,i:i+L(k)-1)').^2))^p;
        elseif (length(Y)-i-1)<L(k)
            forward(k,i)=P*(sum((Y(i-L(k)+1:i)-xf(k,i-L(k)+1:i)').^2))^p;
            backward(k,i)=P*(sum((Y(i:end)-xb(k,i:end)').^2))^p;        
        else
            forward(k,i)=P*(sum((Y(i-L(k)+1:i)-xf(k,i-L(k)+1:i)').^2))^p;
            backward(k,i)=P*(sum((Y(i:i+L(k)-1)-xb(k,i:i+L(k)-1)').^2))^p;  
        end
    end
end
nom=sum(backward)+sum(forward);
backward=backward./repmat(nom,size(backward,1),1);
forward=forward./repmat(nom,size(forward,1),1);
 X0=sum(forward.*xf+backward.*xb);
% X(end)=X(end-1);
X0=X0';
% end

% vv2=X0;
% clearvars -except vv tt X centX centY;
%  uisave({'tt','vv','X','centX','centY'},'vv_tt_0208.mat');
 subplot(2,1,1)
 plot(tt,vv)
 subplot(2,1,2)
 plot(tt,X0)
saveas(gcf,['I:\PAO1_rest\MT21\' name '-CKfilter']);
close all
end
