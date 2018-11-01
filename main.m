

dd=loadwriter(10027)
dd;

%loadwriter
function d= loadwriter( writerid )



%generate 5 ranbdom no btwn 1 and 8 
numbers=[1,2,3,4,5,6,7,8];

numbertopick=4
pickednums=[]
arrsize=size(numbers)
arrsize=arrsize(2);


for i=1:numbertopick 
   num=round(ceil(rand([1,1])*arrsize)); 
   pickednums=[pickednums numbers(num)]
   numbers(num)=[];
   arrsize=arrsize-1
end 

writerinfo={};
%load xml files
for i =1:numbertopick
   pathtoxml="combined/"+num2str(writerid)+"/"+pickednums(i)+".xml";
   disp("loading .."+pathtoxml);
 xml=xml2struct(pathtoxml)
 stroke=xml.WhiteboardCaptureSession.StrokeSet.Stroke
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
         disp("  loading point "+num2str(p)+ " out of "+ num2str(numpoint));
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
     disp(pointinfo);
    % disp(size(pointinfo))
      
 end




sz=size(pointinfo);
 
sz=sz(1);

indices=1:1:sz;
newsize=121;

bothsides=5;
picks=newsize/(1+2*bothsides);
picknum=[]

for ii=1:picks
   ss=size(indices);
   ss=ss(2);
  selected=round((sz-1)*rand(1))+1;
 picknum=[picknum indices(selected)];
 indices(selected)=[];
 for j=1:bothsides
    
     picknum=[picknum indices(selected-j) indices(selected+j)];
     indices(selected+j)=[];
     indices(selected-j)=[];
 end
    
end


% sort the indices

sort(indices);
finalt=[];
for k=1:newsize
    finalt(k,:)=pointinfo(indices(k));


end


disp(i);
an(i,:)=finalt(:)
 end
d=an
%get x y t of all xml as multiple array
 
% concatenate all xyt 's together






end



