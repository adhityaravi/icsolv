To solve a new problem, do the following

* Create a matlab function called progpar_problem_name.m with the necessary input parameters. 
  (check one of the progpar function for the structure to be followed for creating a new progpar function)

* Add the progpar_problem_name as one of the cases in the progpar.m function

* If there are any obstacles in the flow, their geometry should be defined in get_ObstacleCoords.m function.
  (already implemented obstacle shapes -> no obstacle, tilted beam, box(or square), cylinder(or circle)).

* Add a new set_problem_name.m function in the BoundaryDefinitions directory.
  (check one of the set function for the structure to be followed for creating a new set function).

* Add the set_problem_name as one of the cases in the spec_boundary_values.m function

* Modify the main incompvis.m script to call the new problem.