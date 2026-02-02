num_samples <- 100000
λ <- 5
Y_samples <- rpois(num_samples, λ)
X_samples <- rbinom(num_samples, size = 100, prob = .05)


hist(X_samples , probability=TRUE , breaks =20, col=rgb (1,0,0,0.4), border="red",
     main="Critical Failures: Binomial (X) vs Poisson (Y)",
     xlab="Number of critical failures in 100 rolls", xlim = c(0 ,20))
hist(Y_samples , probability=TRUE , breaks = 20, col=rgb (0,0,1,0.4), border="blue", add=TRUE)
legend("topright", legend = c("approx. distribution of X", "approx. distribution of Y"),
       fill=c(rgb (1,0,0,0.4), rgb (0 ,0 ,1 ,0.4)))



drones = c(1,1,1,1,0,0)
sum(sample(drones,2,replace=FALSE))==2

n=10000
samples = replicate(n, 2==sum(sample(drones,2, replace=FALSE)))
sum(samples)/n
6/15

## ## Exercise 1.2 in the textbook

## w = c(8.9,7.1,9.1,8.8,10.2,12.4,11.8,10.9,12.7,10.3,8.6,10.7,10.3,8.4,7.7,11.3,7.6,9.6,7.8,10.6,9.2,9.1,7.8,5.7,8.3,8.8,9.2,11.5,10.5,8.8,35.1,8.2,9.3,10.5,9.5,6.2,9.0,7.9,9.6,8.8,7.0,8.7,8.8,8.9,9.4)
## hist(w, breaks =37, probability = TRUE)

## F <- ecdf(w)
## F(10.3)
