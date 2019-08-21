# Optimization techniques

* SRBF
```@docs
surrogate_optimize(obj::Function,::SRBF,lb,ub,surr::AbstractSurrogate,sample_type::SamplingAlgorithm;maxiters=100,num_new_samples=100)
```

* LCBS
```@docs
surrogate_optimize(obj::Function,::LCBS,lb,ub,krig::Kriging,sample_type::SamplingAlgorithm;maxiters=100,num_new_samples=100)
```

* EI
```@docs
surrogate_optimize(obj::Function,::EI,lb,ub,krig::Kriging,sample_type::SamplingAlgorithm;maxiters=100,num_new_samples=100)
```

* DYCORS
```@docs
surrogate_optimize(obj::Function,::DYCORS,lb,ub,krig::Kriging,sample_type::SamplingAlgorithm;maxiters=100,num_new_samples=100)
```

## Adding another optimization method
To add another optimization method, you just need to define a new
SurrogateOptimizationAlgorithm and write its corresponding algorithm, overloading the following:
```
surrogate_optimize(obj::Function,::NewOptimizatonType,lb,ub,surr::AbstractSurrogate,sample_type::SamplingAlgorithm;maxiters=100,num_new_samples=100)
```
