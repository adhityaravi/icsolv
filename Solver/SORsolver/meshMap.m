% script to create a map of the mesh 

function [em_nodes, vl_nodes, vr_nodes, ht_nodes, hb_nodes, in_nodes] = ...
                                                        meshMap(jmax, imax)

% input variables
% -------------------------------------------------------------------------
% imax           - max. cells in x direction
% jmax           - max. cells in y direction

% output variables
% -------------------------------------------------------------------------
% em_nodes       - empty nodes
% vl_nodes       - nodes on the left vertical boundary
% vr_nodes       - nodes on the right vertical boundary
% ht_nodes       - nodes on the top horizontal boundary
% hb_nodes       - nodes on the bottom horizontal boundary
% in_nodes       - interior nodes

Map = zeros(jmax+2, imax+2);

vl_nodes = zeros(jmax, 1);
vr_nodes = zeros(jmax, 1);
ht_nodes = zeros(1, imax);
hb_nodes = zeros(1, imax);
in_nodes = zeros(jmax, imax);
em_nodes = zeros(1,4);

counter = 1;

% map of the mesh with node ids'
for j=1:jmax+2
    for i=1:imax+2
        Map(j, i) = counter;
        counter = counter+1;
    end
end

% vertical node ids'
for j=2:jmax+1
    vl_nodes(j-1) = Map(j, 1);
    vr_nodes(j-1) = Map(j, imax+2);
end

% horizontal node ids'
for i=2:imax+1
    ht_nodes(i-1) = Map(1, i);
    hb_nodes(i-1) = Map(jmax+2, i);
end

% interior node ids'
for j=2:jmax+1
    for i=2:imax+1
        in_nodes(j-1, i-1) = Map(j, i);
    end
end

% empty node ids'
em_nodes(1) = Map(1, 1);
em_nodes(2) = Map(1, imax+2);
em_nodes(3) = Map(jmax+2 ,1);
em_nodes(4) = Map(jmax+2, imax+2);


end
