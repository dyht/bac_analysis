movobj=VideoReader('*.avi');
nframes=movobj.NumberOfFrames;
fps=movobj.FrameRate;
section = 600;
N = ceil(nframes/section);
[centNY,centNX] = beadweightfit(movobj,2);
centX=[];
centY=[];
for i = 1:N
    if i~=N
        centY(1+section*(i-1):section*i,1) = centNY(1+section*(i-1):section*i)-mean(centNY(1+section*(i-1):section*i));
        centX(1+section*(i-1):section*i,1) = centNX(1+section*(i-1):section*i)-mean(centNX(1+section*(i-1):section*i));
    else
        centY(1+section*(i-1):nframes,1) = centNY(1+section*(i-1):end)-mean(centNY(1+section*(i-1):end));
        centX(1+section*(i-1):nframes,1) = centNX(1+section*(i-1):end)-mean(centNX(1+section*(i-1):end));
    end
end
angle = atan2(centY,centX);
deltaAng = diff(angle);  
deltaAng(deltaAng<-pi) = deltaAng(deltaAng<-pi)+2*pi;
deltaAng(deltaAng>pi) = deltaAng(deltaAng>pi)-2*pi;
velocity = deltaAng*fps/2/pi;
vv = run_ave(velocity,10);
tt = ((1:nframes-1)/fps)';