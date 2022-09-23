function change = isChanged(gdef,Mdef,mdef,ldef,hdef,domEigdef)

% get default data
writeOptions(setOptions,[1,6])

% check if user changed data
change = (g==gdef)*(M==Mdef)*(m==mdef)*(l==ldef)...
                 *(hdef==hdef)* (domEigdef==domEigdef) == 0;