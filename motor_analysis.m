file=dir('*.mat');
ccwinterval=[];
cwinterval=[];
meanvelocity=[];
load(file(num).name);
file(num).name;
bias(num,1)=num; 
[count,loccount]=hist(vv,100);
[amppeaks,locpeaks]=findpeaks(count,'minpeakdistance',40);
low=loccount(locpeaks(1));
high=loccount(locpeaks(2));

low=low/3; 
high=high/3; 

CWmeanvelocity(num,1)=mean(vv(vv>high));
CCWmeanvelocity(num,1)=mean(vv(vv<low));
deltavelocity(num,1)=abs(CWmeanvelocity(num,1))-abs(CCWmeanvelocity(num,1));

flag=binswitch(vv,low,high);
[cw,ccw]=interval(flag,tt);
ccw(ccw==0)=[];
ccwinterval=[ccwinterval;ccw];
cw(cw==0)=[];
cwinterval=[cwinterval;cw];
tccw=mean(ccw);
tcw=mean(cw);
cwbias(num,1)=sum(cw)/(sum(ccw)+sum(cw));
cwswitchrate(num,1)=1/tcw;
ccwswitchrate(num,1)=1/tccw;
switchrate(num,1)=2/((1/cwswitchrate(num,1))+(1/ccwswitchrate(num,1)));



