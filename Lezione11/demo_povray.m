%%
clear all
clc

M = load_off('./meshes/cat10.off')

M.VERT = M.VERT - mean(M.VERT);
f = M.VERT(:,1);
f = mean(f(M.TRIV),2);

plot_mesh(M)
axis equal
shading interp

% voglio colorare la mesh con jet 
colors = jet(300);

% riscalo i valori di f per farli andare da 0 a 1
idx = (f-min(f))./range(f);

% ora da 0 a 1 devo farli andare da 0 a 300
idx = floor(299*(f-min(f))./range(f)) +1;



save_mesh_povray(...
    './cat.mesh',...
    M,...
    colors(idx,:));
    %[ones(M.m,1) zeros(M.m,2)]
    