function [ xp ] = Semicondutor( AtomSpacing,WAtoms,LAtoms )
L = (LAtoms - 1) * AtomSpacing;
W = (WAtoms - 1) * AtomSpacing;

numAtoms = LAtoms * WAtoms;

xp(1, :) = linspace(0, L, LAtoms);
yp(1, :) = linspace(0, W, WAtoms);

end

