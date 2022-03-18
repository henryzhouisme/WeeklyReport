%% Program note is put here
% https://github.com/henryzhouisme/WeeklyReport/blob/30e77833eda5c4fe5fc4a58941354f4acc707a32/Week38/R1:%20Simulation%20of%20Slave%20Mechanism/Calculate%20the%20Point%20of%20the%20Slave%20Mechanism.pdf

function slavePointG=calSlavePoint...
         (attachAPointL,attachBPointG,lengthASlave,lengthBSlave,rotaVecAL,bodya)

    % set the vector in the rotating plane a and b
    rotaVecALN=rotaVecAL/norm(rotaVecAL);
    if rotaVecALN(1)==0 & rotaVecALN(2)==0
        veca=[1;0;0];
    elseif rotaVecALN(2)==0 & rotaVecALN(3)==0
        veca=[0;1;0];
    elseif rotaVecALN(1)==0 & rotaVecALN(3)==0
        veca=[1;0;0];
    else
        veca=[-rotaVecALN(2);rotaVecALN(1);0]; veca=veca/norm(veca);
    end
    vecb=cross(veca,rotaVecALN); vecb=vecb/norm(vecb);

    % cal the rotation matrix of bodya
    O=bodya(1,:)';
    OX=(bodya(2,:)'-bodya(1,:)')/norm(bodya(2,:)'-bodya(1,:)');
	OZ=cross(bodya(2,:)'-bodya(1,:)',bodya(3,:)'-bodya(1,:)');
	OZ=OZ/norm(OZ);
	OY=cross(OZ,OX);
	M=[OX,OY,OZ]; %	slavePointG=M*slavePointL+O

    A=norm(M*attachAPointL+O-attachBPointG)^2-lengthBSlave^2;
    B=lengthASlave^2*norm(M*veca)^2;
    C=lengthBSlave^2*norm(M*vecb)^2;
    D=2*lengthASlave*(M*attachAPointL+O-attachBPointG)'*M*veca;
    E=2*lengthBSlave*(M*attachAPointL+O-attachBPointG)'*M*vecb;
    F=2*lengthASlave*lengthBSlave*(M*veca)'*(M*vecb);

    M=A+B-D;
    N=2*E-2*F;
    P=2*A+4*C-2*B;
    Q=2*E+2*F;
    T=A+B+D;

    para=[M N P Q T];
    alpha=roots(para);
    for i=length(alpha):-1:1
        if ~isreal(alpha(i))
        alpha(i)=[];
    end
    end

    % cal the theta and slavePointL
    if length(alpha)==0
        error('ERROR in calSlavePoint: NO SOLUTION')
    else
        slavePointG=[];
        for i=1:length(alpha)
            thetai=2*atan(alpha(i));
            slavePointLi=attachAPointL+lengthASlave*cos(thetai)*veca+lengthBSlave*sin(thetai)*vecb;
            slavePointGi=mapGlobal(slavePointLi,bodya);
            slavePointG=[slavePointG;slavePointGi'];
        end
    end
end

function globalCoord=mapGlobal(localCoord,localSystem)

	O =localSystem(1,:)';
	OX=(localSystem(2,:)'-localSystem(1,:)')/norm(localSystem(2,:)'-localSystem(1,:)');
	OZ=cross(localSystem(2,:)'-localSystem(1,:)',localSystem(3,:)'-localSystem(1,:)');
	OZ=OZ/norm(OZ);
	OY=cross(OZ,OX);

	globalCoord=localCoord(1,:)*OX+localCoord(2,:)*OY+localCoord(3,:)*OZ+O;

end