using Surrogates
using Distributions
#1D
lb = 0.0
ub = 5.0
n = 5
d = 1
Surrogates.sample(n,lb,ub,GridSample(0.1))
Surrogates.sample(n,lb,ub,UniformSample())
Surrogates.sample(n,lb,ub,SobolSample())
Surrogates.sample(n,lb,ub,LatinHypercubeSample())
Surrogates.sample(20,lb,ub,LowDiscrepancySample(10))
Surrogates.sample(5,d,Cauchy())
Surrogates.sample(5,d,Normal(0,4))

#ND
lb = [0.1,-0.5]
ub = [1.0,20.0]
n = 5
d = 2
s = Surrogates.sample(n,lb,ub,GridSample([0.1,0.5]))
Surrogates.sample(n,lb,ub,UniformSample())
Surrogates.sample(n,lb,ub,SobolSample())
Surrogates.sample(n,lb,ub,LatinHypercubeSample())
Surrogates.sample(n,lb,ub,LowDiscrepancySample([10,3]))
Surrogates.sample(n,d,Cauchy())
Surrogates.sample(n,d,Normal(3,5))
