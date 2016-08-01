sed -i 's:include href=":include href="../channels/:g' *cell.nml

cp *.cell.nml ../../NeuroML2/cells/

sed -i 's:include href="../channels/:include href=":g' *cell.nml


cp *.channel.nml cad*nml ../../NeuroML2/channels
