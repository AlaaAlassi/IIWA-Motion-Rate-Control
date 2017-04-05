function [iiwa_DH_Table, T ] = FK_iiwa(Theta,convention,drawframes,linkTransformation)
%Fk_iiwa  
%DISCRIPTION

%	FK_iiwa(Theta)
%	FK_iiwa(Theta, convention)
%   FK_iiwa(Theta, convention,drawframes)

% Theta : is a 1x7 ajoint angles vector in Degrees.
% convention : takes ethier'classical' or 'modified' 
% drawframes : If this varýable is set to 'on' it 
% draws the joint frames from the base to the end effector.

% EXAMPLE 
% FK_iiwa([10 0 0 0 0 0 0],'modified','on')


% See also: InvK_iiwa.
% by Alaa Alassi 

 
if nargin < 2
    convention = 'classical';
end

if nargin < 3
    drawframes = false;
end

if nargin < 4
    linkTransformation = 7;
end


if (~strcmp(convention,'classical')&& ~strcmp(convention,'modified')),
error('E:Fkiiwa','Error in convention argument: use the key word (classical) or (modified)');
end

if (drawframes)
    if ~strcmp(drawframes,'on'),
    error('E:Fkiiwa','Error in drawframes argument: use the key word (on)');
    end
end



 if ~isequal([1 7], size(Theta)),
    error('E:Fkiiwa','Theta must be 1 x 7 Vector');
 end

if(strcmp(convention , 'classical'))

Alpha = [-pi/2  pi/2 pi/2 -pi/2 -pi/2 pi/2 0] ;
a     = zeros(1,7) ;
d     = [.340 0 .400  0  .400 0 .141];
q     = Theta;
q = deg2rad(q);
iiwa_DH_Table = [  Alpha'  a'     d'        q' ];

T01 = DH(iiwa_DH_Table(1,:));
T12 = DH(iiwa_DH_Table(2,:));
T23 = DH(iiwa_DH_Table(3,:));
T34 = DH(iiwa_DH_Table(4,:));
T45 = DH(iiwa_DH_Table(5,:));
T56 = DH(iiwa_DH_Table(6,:));
T67 = DH(iiwa_DH_Table(7,:));


end

if(strcmp(convention,'modified'))

Alpha = [0  -pi/2  pi/2 pi/2 -pi/2 -pi/2 pi/2] ;
a     = zeros(1,7) ;
d     = [.340 0 .400  0  .400 0 .141]; 
q     = Theta;
q = deg2rad(q);
iiwa_DH_Table = [  Alpha'  a'     d'        q'];

T01 = Craig(iiwa_DH_Table(1,:));
T12 = Craig(iiwa_DH_Table(2,:));
T23 = Craig(iiwa_DH_Table(3,:));
T34 = Craig(iiwa_DH_Table(4,:));
T45 = Craig(iiwa_DH_Table(5,:));
T56 = Craig(iiwa_DH_Table(6,:));
T67 = Craig(iiwa_DH_Table(7,:));


end


% Temp = zeros(4,4,7);

    T02 =  T01 * T12;
    T03 =  T02 * T23;  
    T04 =  T03 * T34;  
    T05 =  T04 * T45;  
    T06 =  T05 * T56;  
    T07 =  T06 * T67;
    

    if (linkTransformation == 1)
    T = T01 ;
   
    elseif (linkTransformation == 2)
    T = T02 ;
    
    elseif (linkTransformation == 3)
    T = T03 ;
    
    elseif (linkTransformation == 4)
    T = T04 ;
    
    elseif (linkTransformation == 5)
    T = T05 ;
    
    elseif (linkTransformation == 6)
    T = T06 ;
    
    else
    T   =  T07;
    end
  
    if (strcmp(drawframes,'on'))
        
    plot_iiwa(Theta)

    end
   

end

