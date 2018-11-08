
writers=10060:1:10065;
sz=size(writers);
sz=sz(2);
dds=[];
for i=1:sz

    dd=loadwriter(writers(i));
    dds=[dds dd];
end


%loadwriter
function d= loadwriter( writerid )



%generate 5 ranbdom no btwn 1 and 8 
numbers=[1,2,3,4,5,6,7,8];

numbertopick=2;
pickednums=[];
arrsize=size(numbers);
arrsize=arrsize(2);
finalt=[];

for i=1:numbertopick 
   num=round(ceil(rand([1,1])*arrsize)); 
   pickednums=[pickednums numbers(num)];
   numbers(num)=[];
   arrsize=arrsize-1;
end 
%pickednums;
writerinfo={};
%load xml files
for i =1:numbertopick
   pathtoxml="combined/"+num2str(writerid)+"/"+pickednums(i)+".xml";
   disp("loading .."+pathtoxml);
 xml=xml2struct(pathtoxml);
 stroke=xml.WhiteboardCaptureSession.StrokeSet.Stroke;
 numstroke=size(stroke);
 numstroke=numstroke(2);
 pointinfo=[];
 pointindex=1;
 for st=1:numstroke
     % stroke
     
     points=stroke{st}.Point;
     numpoint=size(points);
     numpoint=numpoint(2);
     
     for p=1:numpoint
        % disp("  loading point "+num2str(p)+ " out of "+ num2str(numpoint));
         if(numpoint==1)
                x=str2double(points.Attributes.x);
         y=str2double(points.Attributes.y);
         t=str2double(points.Attributes.time);
         else
             x=str2double(points{p}.Attributes.x);
         y=str2double(points{p}.Attributes.y);
         t=str2double(points{p}.Attributes.time);
         end
         ele=[x;y;t];
         pointinfo(pointindex,:)=ele;
         pointindex=pointindex+1;
     end
    % disp(pointinfo);
    % disp(size(pointinfo))
      
 end




sz=size(pointinfo);
 %disp(sz);
 
sz=sz(1);

indices=1:1:sz;
newsize=121;

bothsides=5;
picks=newsize/(1+2*bothsides);
picknum=[];

for ii=1:picks
   ss=size(indices);
   ss=ss(2);
  selected=round((ss-2*bothsides-1)*rand(1))+1+bothsides;
%   disp(ss);
 picknum=[picknum indices(selected)];
 indices(selected)=[];
 for j=1:bothsides
    
     picknum=[picknum indices(selected-j) indices(selected+j)];
     indices(selected+j)=[];
     indices(selected-j)=[];
 end
    
end


% sort the indices

picknum=sort(picknum);
%disp(picknum);
 f=[];
for k=1:newsize
    f=[f pointinfo(picknum(k),:)];


end
 

finalt(i,:)=f(:);
end

d=finalt';
%get x y t of all xml as multiple array
 
% concatenate all xyt 's together






end



