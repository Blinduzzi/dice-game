function siminput = randomstart(siminput)
% siminput = setVariable(siminput,"varname",value,"Workspace","modelname");
siminput = setVariable(siminput,"seed",randi(1e5),"Workspace","targetDice");
end