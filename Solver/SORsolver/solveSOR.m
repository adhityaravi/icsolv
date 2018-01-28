% script to implement SOR algorithm

function [sol, it, res] = solveSOR(A, b, omega, xcur, epsi, itermax)

% input variables
% -------------------------------------------------------------------------
% A             - system matrix
% b             - right hand side of the system
% omega         - relaxation parameter
% xcur          - initial value
% epsi          - precision criterion
% itermax       - max. allowed iteration

% output variables
% -------------------------------------------------------------------------
% sol           - solution
% it            - iteration at which solution converged
% res           - residue of the converged solution

n = size(A,1);

res = 100;
it = 1;
sum1 = 0;
sum2 = 0;
xnxt = zeros(n, 1);

% SOR algorithm
while (res > epsi) && (it < itermax)
   for i=1:n
       for j=1:i-1
           tmp1 = A(i, j)*xnxt(j);
           sum1 = sum1+tmp1;
       end
       for k=i+1:n
           tmp2 = A(i, k)*xcur(k);
           sum2 = sum2+tmp2;
       end
       xnxt(i) = ((1-omega) * xcur(i)) + ((omega/A(i,i)) * (b(i) - ...
                 sum1 - sum2));
       sum1 = 0;
       sum2 = 0;
   end
   err = xnxt - xcur;
   res = norm(err, 2);
   xcur = xnxt;
   it = it+1;
end

sol = xnxt;

end
       
