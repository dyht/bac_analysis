tic
lowthreshold=-30;
highthreshold=70;
if(vv(1)>0)
    flag(1)=1;
else
    flag(1)=-1;
end

for i=2:length(vv)
    if flag(i-1)>0
        if(vv(i)>lowthreshold)
            flag(i)=1;
        else
            flag(i)=-1;
        end
    else
        if(vv(i)<highthreshold)
            flag(i)=-1;
        else
            flag(i)=1;
        end
    end
end
toc
      