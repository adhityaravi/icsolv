% script to construct the system matrix for the pressure equation 

function A = buildSysmat(jmax, imax)

% input variables
% -------------------------------------------------------------------------
% imax          - max. cells in the x direction
% jmax          - max. cells in the y direction

% output variables
% -------------------------------------------------------------------------
% A             - System matrix for the pressure equation

A = zeros((jmax+2)*(imax+2));

% fetching the mesh map
[~, vl_nodes, vr_nodes, ht_nodes, hb_nodes, in_nodes] = ...
                                                       meshMap(jmax, imax);

% horizontal boundary nodes
for i=1:imax
    A(ht_nodes(i), ht_nodes(i)) = 1;
    A(ht_nodes(i), ht_nodes(i)+(imax+2)) = -1;
    A(hb_nodes(i), hb_nodes(i)) = 1;
    A(hb_nodes(i), hb_nodes(i)-(imax+2)) = -1;
end

% vertical boundary nodes
for j=1:jmax
    A(vl_nodes(j), vl_nodes(j)) = 1;
    A(vl_nodes(j), vl_nodes(j)+1) = -1;
    A(vr_nodes(j), vr_nodes(j)) = 1;
    A(vr_nodes(j), vr_nodes(j)-1) = -1;
end

in_nodes = in_nodes(:);

% inner nodes
for i=1:(imax*jmax)
    A(in_nodes(i), in_nodes(i)) = -4;
    A(in_nodes(i), in_nodes(i)+1) = 1;
    A(in_nodes(i), in_nodes(i)-1) = 1;
    A(in_nodes(i), in_nodes(i)+(imax+2)) = 1;
    A(in_nodes(i), in_nodes(i)-(imax+2)) = 1;
end

end
    
    