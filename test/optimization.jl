using Surrogates
using LinearAlgebra
using Flux
using Flux: @epochs

#######SRBF############

##### 1D #####
objective_function = x -> 2*x+1
x = [2.5,4.0,6.0]
y = [6.0,9.0,13.0]

# In 1D values of p closer to 2 make the det(R) closer and closer to 0,
#this does not happen in higher dimensions because p would be a vector and not
#all components are generally C^inf
p = 1.99
a = 2
b = 6

#Using Kriging
my_k_SRBF1 = Kriging(x,y,p)
surrogate_optimize(objective_function,SRBF(),a,b,my_k_SRBF1,UniformSample())

#Using RadialBasis
my_rad_SRBF1 = RadialBasis(x,y,a,b,z->norm(z),1)
surrogate_optimize(objective_function,SRBF(),a,b,my_rad_SRBF1,UniformSample())

##### ND #####
objective_function_ND = z -> 3*norm(z)+1
lb = [1.0,1.0]
ub = [6.0,6.0]
x = sample(5,lb,ub,SobolSample())
y = objective_function_ND.(x)
p = [1.5,1.5]
theta = [1.0,1.0]

#Kriging

my_k_SRBFN = Kriging(x,y,p,theta)
surrogate_optimize(objective_function_ND,SRBF(),lb,ub,my_k_SRBFN,UniformSample())

#Radials
lb = [1.0,1.0]
ub = [6.0,6.0]
x = sample(5,lb,ub,SobolSample())
bounds = [lb,ub]
objective_function_ND = z -> 3*norm(z)+1
y = objective_function_ND.(x)
my_rad_SRBFN = RadialBasis(x,y,bounds,z->norm(z),1)
surrogate_optimize(objective_function_ND,SRBF(),lb,ub,my_rad_SRBFN,UniformSample())

# Lobachesky
x = sample(5,lb,ub,UniformSample())
y = objective_function_ND.(x)
alpha = [2.0,2.0]
n = 4
my_loba_ND = LobacheskySurrogate(x,y,alpha,n,lb,ub)
surrogate_optimize(objective_function_ND,SRBF(),lb,ub,my_loba_ND,UniformSample())

#Linear
lb = [1.0,1.0]
ub = [6.0,6.0]
x = sample(500,lb,ub,SobolSample())
objective_function_ND = z -> 3*norm(z)+1
y = objective_function_ND.(x)
my_linear_ND = LinearSurrogate(x,y,lb,ub)
surrogate_optimize(objective_function_ND,SRBF(),lb,ub,my_linear_ND,SobolSample(),maxiters=15)

#SVM
lb = [1.0,1.0]
ub = [6.0,6.0]
x = sample(5,lb,ub,SobolSample())
objective_function_ND = z -> 3*norm(z)+1
y = objective_function_ND.(x)
my_SVM_ND = SVMSurrogate(x,y,lb,ub)
surrogate_optimize(objective_function_ND,SRBF(),lb,ub,my_SVM_ND,SobolSample(),maxiters=15)

#Neural
lb = [1.0,1.0]
ub = [6.0,6.0]
x = sample(5,lb,ub,SobolSample())
objective_function_ND = z -> 3*norm(z)+1
y = objective_function_ND.(x)
model = Chain(Dense(2,1))
loss(x, y) = Flux.mse(model(x), y)
opt = Descent(0.01)
n_echos = 1
my_neural_ND_neural = NeuralSurrogate(x,y,lb,ub,model,loss,opt,n_echos)
surrogate_optimize(objective_function_ND,SRBF(),lb,ub,my_neural_ND_neural,SobolSample(),maxiters=15)

#Random Forest
lb = [1.0,1.0]
ub = [6.0,6.0]
x = sample(5,lb,ub,SobolSample())
objective_function_ND = z -> 3*norm(z)+1
y = objective_function_ND.(x)
num_round = 2
my_forest_ND_SRBF = RandomForestSurrogate(x,y,lb,ub,num_round)
surrogate_optimize(objective_function_ND,SRBF(),lb,ub,my_forest_ND_SRBF,SobolSample(),maxiters=15)

#Inverse distance surrogate
lb = [1.0,1.0]
ub = [6.0,6.0]
x = sample(5,lb,ub,SobolSample())
objective_function_ND = z -> 3*norm(z)+1
p = 2.5
y = objective_function_ND.(x)
my_inverse_ND = InverseDistanceSurrogate(x,y,p,lb,ub)
surrogate_optimize(objective_function_ND,SRBF(),lb,ub,my_inverse_ND,SobolSample(),maxiters=15)

#SecondOrderPolynomialSurrogate
lb = [0.0,0.0]
ub = [10.0,10.0]
obj_ND = x -> log(x[1])*exp(x[2])
x = sample(5,lb,ub,UniformSample())
y = obj_ND.(x)
my_second_order_poly_ND = SecondOrderPolynomialSurrogate(x,y,lb,ub)
surrogate_optimize(obj_ND,SRBF(),lb,ub,my_second_order_poly_ND,SobolSample(),maxiters=15)

####### LCBS #########
######1D######
objective_function = x -> 2*x+1
x = [2.0,4.0,6.0]
y = [5.0,9.0,13.0]
p = 1.8
a = 2
b = 6
my_k_LCBS1 = Kriging(x,y,p)
surrogate_optimize(objective_function,LCBS(),a,b,my_k_LCBS1,UniformSample())


##### ND #####
objective_function_ND = z -> 3*norm(z)+1
x = [(1.2,3.0),(3.0,3.5),(5.2,5.7)]
y = objective_function_ND.(x)
p = [1.2,1.2]
theta = [2.0,2.0]
lb = [1.0,1.0]
ub = [6.0,6.0]

#Kriging
my_k_LCBSN = Kriging(x,y,p,theta)
surrogate_optimize(objective_function_ND,LCBS(),lb,ub,my_k_LCBSN,UniformSample())


##### EI ######

###1D###
objective_function = x -> 2*x+1
x = [2.0,4.0,6.0]
y = [5.0,9.0,13.0]
p = 2
a = 2
b = 6
my_k_EI1 = Kriging(x,y,p)
surrogate_optimize(objective_function,EI(),a,b,my_k_EI1,UniformSample(),maxiters=200,num_new_samples=155)


###ND###
objective_function_ND = z -> 3*norm(z)+1
x = [(1.2,3.0),(3.0,3.5),(5.2,5.7)]
y = objective_function_ND.(x)
p = [1.2,1.2]
theta = [2.0,2.0]
lb = [1.0,1.0]
ub = [6.0,6.0]

#Kriging
my_k_E1N = Kriging(x,y,p,theta)
surrogate_optimize(objective_function_ND,EI(),lb,ub,my_k_E1N,UniformSample())


## DYCORS ##

#1D#
objective_function = x -> 3*x+1
x = [2.1,2.5,4.0,6.0]
y = objective_function.(x)
p = 1.9
lb = 2.0
ub = 6.0

my_k_DYCORS1 = Kriging(x,y,p)
surrogate_optimize(objective_function,DYCORS(),lb,ub,my_k_DYCORS1,UniformSample())

my_rad_DYCORS1 = RadialBasis(x,y,lb,ub,z->norm(z),1)
surrogate_optimize(objective_function,DYCORS(),lb,ub,my_rad_DYCORS1,UniformSample())


#ND#
objective_function_ND = z -> 2*norm(z)+1
x = [(2.3,2.2),(1.4,1.5)]
y = objective_function_ND.(x)
p = [1.5,1.5]
theta = [2.0,2.0]
lb = [1.0,1.0]
ub = [6.0,6.0]
bounds = [lb,ub]


my_k_DYCORSN = Kriging(x,y,p,theta)
surrogate_optimize(objective_function_ND,DYCORS(),lb,ub,my_k_DYCORSN,UniformSample(),maxiters=30)

my_rad_DYCORSN = RadialBasis(x,y,bounds,z->norm(z),1)
surrogate_optimize(objective_function_ND,DYCORS(),lb,ub,my_rad_DYCORSN,UniformSample(),maxiters=30)
