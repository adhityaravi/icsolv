To solve a new problem, do the following

* Create a matlab function called progpar_problem_name.m with the necessary input parameters. 
  (check one of the progpar scripts for the structure to be followed for creating a new progpar function)
* Add the progpar_problem_name as one of the cases in the progpar.m function
* If there are any obstacles in the flow, their geometry should be defined in get_ObstacleCoords.m function.
  (already implemented obstacle shapes -> no obstacle, tilted beam, box(or square), cylinder(or circle)).
* Modify the main incompvis.m script to call the new problem.