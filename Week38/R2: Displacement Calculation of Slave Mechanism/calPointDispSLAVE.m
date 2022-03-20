
function [dmS,dcS]=calPointDispSLAVE(pS,pA,pB,...
                                   dmA,dcA,dmB,dcB,bodya,vecRota)
    H=[eye(3),-eye(3);-eye(3),eye(3)];

    O=bodya(1,:)';
    OX=(bodya(2,:)'-bodya(1,:)')/norm(bodya(2,:)'-bodya(1,:)');
	OZ=cross(bodya(2,:)'-bodya(1,:)',bodya(3,:)'-bodya(1,:)');
	OZ=OZ/norm(OZ);
	OY=cross(OZ,OX);
	Msp=[OX,OY,OZ]; %	slavePointG=M*slavePointL+O

	cmAS=1/dist(pA',pS)*[pA'-pS',pS'-pA'];
    cmBS=1/dist(pB',pS)*[pB'-pS',pS'-pB'];

    dmS =pinv([cmAS(1,1:3);cmBS(1,1:3);vecRota'*inv(Msp)])*...
         [cmAS(1,1:3)*dmA;cmBS(1,1:3)*dmB;vecRota'*inv(Msp)*dmA];

    cmDOTdcA=zeros(6,6);
    cmDOTdcB=zeros(6,6);
    for i=1:6
        for j=1:6
            cmDOTdcA(i,i)=cmAS(1,1:3)*dcA(i,j,:);
            cmDOTdcB(i,i)=cmBS(1,1:3)*dcB(i,j,:);
        end
    end

    dcS_=pinv([cmAS(1,1:3);cmBS(1,1:3);vecRota'*inv(Msp)])*...
         [reshape(cmDOTdcA+1/2/dist(pA',pS)*([dmA;dmS]'*H*[dmA;dmS]),1,36);...
          reshape(cmDOTdcB+1/2/dist(pB',pS)*([dmB;dmS]'*H*[dmB;dmS]),1,36);...
          reshape(vecRota*inv(Msp),1,36)];
    dcS=reshape(dcS_,6,6)';

end

