
library(reticulate)

csd = import("casadi")

source("casadi_generics.R")


x = csd$MX$sym('x', 5L)
y = csd$norm_2(x)
grad_y = csd$gradient(y, x)
f = csd$Function('f', list(x), list(grad_y))
grad_y_num = f(c(1, 2, 3, 4, 5))

x = csd$MX$sym('x', 2L)
z = 1 - x[1]**2
rhs = csd$vertcat(z * x[0] - x[1], x[0])

ode = list()
ode[["x"]] = x
ode[["ode"]] = rhs

tgrid = seq(0, 4, length = 100)

F = csd$integrator('F','cvodes', ode, list(tf = 4, grid = tgrid))

res = F(x0 = c(0, 1))
tmp = t(res$xf$full())

# Optimal control example
x = csd$MX$sym('x', 2L)
p = csd$MX$sym('p')

z = 1-x[1]**2;
rhs = csd$vertcat(z*x[0]-x[1]+2*csd$tanh(p),x[0])

# ODE declaration with free parameter
ode = list("x" = x, "p" = p, "ode" = rhs)

# Construct a Function that integrates over 1s
F = csd$integrator('F','cvodes',ode,list(tf = 1))

# Control vector
u = csd$MX$sym('u',4L,1L)

x = c(0, 1)  # Initial state
for (i in 0:3) {
  # Integrate 1s forward in time:
  # call integrator symbolically
  res = F(x0=x,p=u[i])
  x = res$xf
}

# NLP declaration
nlp = list()
nlp[["x"]] = u
nlp[["f"]] = csd$dot(u, u)
nlp[["g"]] = x

solver = csd$nlpsol('solver','ipopt',nlp)
res = solver(x0=0.2,lbg=0,ubg=0)


