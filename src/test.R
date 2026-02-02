# How to use: run all the commands in order, reading the documentation.

#_______________________________________________________________________________
#
# SECTION 1. VECTORS
#_______________________________________________________________________________

# The R language is very good with working with vectors. By default, most
# things are vectors. R does not distinguish between row and column vectors.

# One way to construct a vector is to use the function `c()` which combines
# values into a vector or list:
u=c(5,0,1,8) # construct the vector (5,0,1,8)
u

# Another way is to use colon syntax to construct sequential values:
v=7:10 # construct the vector (7,8,9,10)
v


# Most functions are "vectorized" and by default act componentwise, as
# you can see in these calculations:
exp(u)  # apply the exponential function to each entry of u 
u*v # multiply u and v componentwise
u-v
w=u+v
w
# REMARK: R is optimized to do vectorized calculations like these extremely
# quickly. For non-vectorized calculations (i.e., calculations involving loops
# or repeated function calls), R tends to be very slow relative to other
# languages.

# Accessing entries or subsets of vectors is done using square brackets:
w[1] # the first entry of the vector w
w[3] # the third entry of the vector w
w[0] # the type of the entries (in this case, this is an integer vector)

# we can access a subset of the entries as follows:
w[1:3] # the first, second, and third entries of w

# Suppose we want only the 1st, 3rd, and 4th entries of w. We can access them
# as follows:
i = c(1,3,4)
w[i]
# Equivalently, we can tell R to exclude the second entry:
w[-2] 

# of couse, you don't have to use vectorize operations. You can do normal
# operations too:
1+5
2*3
exp(0) # e⁰
exp(1) # e¹
exp(3) # e³


#_______________________________________________________________________________
#
# SECTION 2. SAMPLING FROM A POPULATION
#_______________________________________________________________________________

# The first function we'll look at is `sample()`, which draws a random sample
# (of a specified size) from a specified finite collection of objects (called
# a 'population' in stats jargon).
population = 1:6 # this is the set {1,2,3,4,5,6}. This is the 'population' we
                 # will sample from.
n <- 40 # sample size
X <- sample(population,n,replace=TRUE)
# COMMENTARY: the above code samples n random numbers independently according
# to the unform distribution on the set {1,2,...,6}, which we've called the
# 'population'. The tag replace=TRUE tells us that we are sampling 'with
# replacement'. In effect, X is the list of results of rolling a 6-sided dice
# n times.

# the sample() function allows us to choose any finite set as our population.
# For example, our population might consist of an urn with 3 red balls and 2
# blue balls:
urn <- c("red","red","red","blue","blue")

sample(urn,3,replace=TRUE) 
# COMMENTARY: the above line of code draws three balls out of the urn, putting
# the ball back in the urn after each draw. This is called sampling 'with
# replacement'.

sample(urn,3,replace=FALSE)
# COMMENTARY: the above line of code draws three balls out of the urn, but
# here we DON'T put the balls back in the urn after each draw. This is called
# sampling 'without replacement'.

# Let's say we want to know what proportion of draws will be red balls. We'll
# use the command '==', which allows comparison of values in vectors. For
# example, the line
draw <- sample(urn,3,replace=TRUE)
draw
draw=="red"

# The above line returns a vector of Boolean values (TRUE or FALSE) depending
# on whether the draws are red or not. We can save this last vector as b (for
# boolean):
b <- draw=="red"
b
# R treats TRUE and FALSE as 1 and zero, so we can count the number of balls
# that were red with the command
sum(b)
# we can also compute the mean, which in this case gives us the PROPORTION of
# balls drawn that were red:
mean(b)

# let's say we want to replicate the experiment of drawing 3 balls from the
# urn with replacement 40 times, recording the number of red balls each time.
# For this, we can use the function replicate(), as follows
replicate(40, sample(urn,3,replace=TRUE))

# now let's say we want to record only the proportion of red balls on each draw:
proportions_red <- replicate(40, mean(sample(urn,3,replace=TRUE)=="red"))
proportions_red
mean(proportions_red) # this gives the proportion of red balls from all draws

# EXERCISE: what happens as we increase the number of replicates from 40 to
# 400? To 4000? To 40000? To 4,000,000? Explain why your observations make
# sense, in the context of the law of large numbers.

# EXERCISE: answer the previous question, but sample the balls without
# replacement. Do the averages agree?

# EXERCISE: (Guided problem to show that when drawing 3 balls from an urn with
# five balls (R) (R) (R) (B) (B), the expected proportion of draws that are
# red = 3/5). First, compute the probability that the first draw is red. Next,
# use conditioning to prove that the second draw and third also has
# probability 3/5 of being red. Notation: B_k = kth draw is blue, R_k = kth
# draw is red. Need to show that P(R_k)=3/5 for k=1,2,3. Finally, introduce
# indicator variables so that the number of red balls drawn is I_1+I_2+I_3.
# Hence the proportion of red balls dran is (I_1+I_2+I_3)/3. Taking
# expectations and using linearity, we find that the expected proportion is
# 3/5, which matches our numerical result. This is a good problem to introduce
# (1) the law of total probabiliity, (2) conditioning, (3) indicator variables

# Here's another example: flipping a coin. The following two lines both do the
# same thing: flip a fair coin three times:
sample(c("H","T"),3,replace=TRUE)
sample(c("H","T"),3,replace=TRUE,prob=c(.5,.5))

# We can also flip an unfair coin. Suppose we wish to make the probability of
# heads .6 and the probability of tails .4. We can do this as well:
sample(c("H","T"),3,replace=TRUE,prob=c(.6,.4))


# The function `sample()` is also useful for generating random permutations of
# objects. For example, let's generate a random permutation of the numbers
# 1,...,52:
sample.int(52, replace=FALSE) # shuffling a deck of cards :)

sample(1:52, replace=FALSE) # shuffling a deck of cards :)


# REMARK: One of the most important skills in coding is knowing how to look up
# and read documentation. To get more information about any function,
# you can see the documentation with the help() function:
help(sample)
# For a well-documented and widely-used language like R, ChatGPT is also a
# good source for doumentation, but sometimes it makes things up.

# COMMENTARY ABOUT DOCUMENTATION: The help() function will give a long
# description and usually some examples. Most of the output won't make sense
# yet. But it is very important that you learn how to look up and read
# documentation, and R has very good documentation. For now, the most
# important things to look for are at the beginnning. Here's some of the
# output of `help(sample)`:

## Description:
##
##      ‘sample’ takes a sample of the specified size from the elements of
##      ‘x’ using either with or without replacement.
##
## Usage:
##
##      sample(x, size, replace = FALSE, prob = NULL)
##     
##      sample.int(n, size = n, replace = FALSE, prob = NULL,
##                 useHash = (n > 1e+07 && !replace && is.null(prob) && size <= n/2))
##     
## Arguments:
##
##        x: either a vector of one or more elements from which to choose,
##           or a positive integer.  See ‘Details.’
##
##        n: a positive number, the number of items to choose from.  See
##           ‘Details.’
##
##     size: a non-negative integer giving the number of items to choose.
##
##  replace: should sampling be with replacement?
##
##     prob: a vector of probability weights for obtaining the elements of
##           the vector being sampled.

# COMMENTARY, CONTINUED: In the above, the 'Arguments' are the inputs to the
# function. In the 'Usage' section, we find the line
#
#       sample(x, size, replace = FALSE, prob = # NULL).
#
# This says that `sample()` takes up to four arguments. The *mandatory*
# arguments are 'x' and 'size'. On the other hand, the arguments 'replace' and
# 'prob' are OPTIONAL arguments (you can tell because of the = sign, which
# says what their default value is when not specified by the user. For
# example, by default 'replace' is set to FALSE whenever it is not provided by
# the user in the function call).
#
# REMARK: If you don't understand a function or its documentation, ask ChatGPT
# to explain it. It's really good at that. You can also ask ChatGPT to code
# for you. I have mixed feelings about that. On one hand, it often gives
# correct and well-written code. On the other hand, it takes a lot of the fun
# out of coding and like TikTok will turn your brain to mush. That said, if
# you ever get a very confusing error message, one extremely useful thing you
# can do is copy-paste the error message into ChatGPT and ask for an
# explanation.



#_______________________________________________________________________________
#
# SECTION 3. SAMPLING PROBABILITY DISTRIBUTIONS: UNIFORM AND NORMAL
#_______________________________________________________________________________

# Sometimes we'll want to sample according to prespecified distributions.

# UNIFORM DISTRIBUTION
n=10
U = runif(n, min=0, max=4)
U
head(U)
# COMMENTARY: the above command generates a vector of n random numbers sampled
# independently according to the uniform distribution on the open interval
# (0,4).

# We can compute basic summary statistics from our sample:
max(U)
min(U)
mean(U)
median(U)
sd(U)
var(U)

# REMARK: In R, when we draw random samples from a pre-specified distribution
# (in this case, the uniform distribution), the name of the function (in this
# case runif) starts with an 'r', which stands for RANDOM. Because we're
# drawing RANDOM samples.

help(runif)


# NORMAL DISTRIBUTION
n=100000
Z = rnorm(n, mean=0, sd=1)
head(Z)

# We can compute basic summary statistics:
max(Z)
min(Z)
mean(Z)
median(Z)
sd(Z)
var(Z)

# COMMENTARY: The above code draw n samples indpendently from a normal
# distribution. A normal distribution is specified by a mean (in this case 0)
# and a standard deviation (in this case 1). This choice of mean and standard
# deviation is called the "standard normal" distribution.

#_______________________________________________________________________________
#
# SECTION 4. MAKING HISTOGRAMS
#_______________________________________________________________________________

# Histograms are one of the best ways to visualize a distribution of numbers.
# A histogram divides the RANGE of values into intervals, and then counts the
# number of observations falling in each interval.
hist(U)
hist(Z)
# By default, R tries to intelligently decide how to divide the range of
# numeric values into intervals, but you can specify this manually if you
# want. One way to do this is to specify the number of breaks:
hist(U,breaks=20) 
hist(Z,breaks=100) # ooh pretty <(^-^)>

# COMMENTARY: The above are FREQUNCY HISTOGRAMS (the heights of the bars are
# counts, so if sum the heights, you get n).

# Another type of histogram is the DENSITY HISTOGRAM (an example
# of what our textbook calls "Relative frequency histograms"), which is
# normalized to have total area one. To construct probability density
# hisogram, we simply adding the optional argument 'probability = TRUE'
hist(Z, breaks=100, probability = TRUE) 
# Note that the heights of the bars do not need to sum to 1. Their areas do.
# Here's another example:
n=10
V = runif(n, min=0, max=4)
hist(V, breaks = 12, probability = TRUE)
# Density histograms are useful because they give us a visual approximation of
# the probability density function of the data.

# REMARK: You can also adjust histogram properties, like (1) exactly where the
# breaks are, (2) the labels, and (3) the height of the vertical axes using
# various options. See help(hist). Creating pretty figures is one area where
# ChatGPT is pretty useful and probably doesn't result in a significant loss
# of gray matter.


#_______________________________________________________________________________
#
# SECTION 5. MORE DISTRIBUTIONS: BINOMIAL AND MULTINOMIAL
#_______________________________________________________________________________

# BINOMIAL DISTRIBUTION

# The main idea of binomial distribution coin flipping. You have a coin that
# lands heads with probabilty p. Flip the coin n times. Let X be the number of
# heads you got. Then we say X is binomially distributed Bin(n,p).

# The standard nomenclature for the binomial distribution is as follows:
# - each flip of the coin is called a "trial"
# - n is called the "number of trials"
# - p is called the "probability of success"
# - an entire run consisting of all n trials is called an "experiment"

# We can generate binomial random variables using the function rbinom() as
# follows:

rbinom(1,size=3,prob=.6)) # do 1 experimental trial where you flip a biased
                          # coin 3 times and count the number of heads. The
                          # probability of heads is specified as .6

rbinom(1,size=1000,prob=.6) # do 1 experimental trial where you flip a biased
                            # coin 1000 times and count the number of heads

rbinom(5,size=1000,prob=.6) # do 5 experimental trial where you flip a biased
                            # coin 1000 times and count the number of heads

help(rbinom)

# MULTINOMIAL DISTRIBUTION

# Suppose there are 4 differently colored rabbits: black, gray, white, and
# red. We go out into the wild and collect 100 rabbits at random.

# Let X=(X₁,X₂,X₃,X₄) be a random vector where X₁ is the number of black
# rabbits, X₂ the number of gray rabbits, X₃ the number of white rabbits, and
# X₄ the number of red rabbits.
#
# Let us suppose that, in the wild, 25% of rabbits are black, 35% are gray,
# 38% are white, and 2% are red. The probability mass function of X is
# specified by the following vector:

rabbit_distribution = c(.25,.35,.38,.02) 
  
# To generate an instantiation of X, we use the MULTINOMIAL DISTRIBUTION,
# which is amazing:

rmultinom(1,size=100,prob=rabbit_distribution)

# did we see a red rabbit?

# suppose we went out into the wild and repeated this experiment 7 times:
M = rmultinom(7,size=100,prob=rabbit_distribution)

# COMMENTARY: the output is a matrix!  We can select it 

M[,1] # the 1st column (the outcome of our 1st rabbit-collecting expedition)
M[,2] # the 2nd column (the outcome of our 2nd rabbit-collecting expedition)

M[1,] # the 1st row (the number of black rabbits across all expeditions)
M[2,] # the 2nd row (the number of gray rabbits across all expeditions)
M[4,] # the 4th row (the number of red rabbits across all expeditions)

sum(M[4,]) # the total number of red rabbits across all expeditions
mean(M[4,]) # the average number of red rabbits per expedition

# Now, suppose that a rabbit collector offers to pay us for the rabbits we
# collected. She offers $5 for every black rabbit, $3 for every gray rabbit,
# $1 for every white rabbit, and $100 for every red rabbit.

rabbit_prices = c(5,3,1,100)
first_expedition=M[,1]


rabbit_prices
first_expedition
first_expedition*rabbit_prices # the money we can get from the collector, for
                              # black, gray, white and red rabbits
                              # respectively.

sum(first_expedition*rabbit_prices) # the total $$$ haul from the first
                                    # expedition

# vectorized operations let us do this over all expeditions at once, as
# follows:
M
M*rabbit_prices # note that is not matrix multiplication. We have multiplied
               # each column componentwise by the vector rabbit_prices
colSums(M*rabbit_prices) # interpret
rowSums(M*rabbit_prices) # interpret
sum(M*rabbit_prices) # interpret


# Dice rolls, again
d = rmultinom(1,size=100,prob=c(1/6,1/6,1/6,1/6,1/6,1/6))
# COMMENTARY: The above line executes a single multinomial trial consisting of
# rolling a 6-sided dice 100 times.


# We can repeat the trial 40 times:
D = rmultinom(40,size=100,prob=c(1/6,1/6,1/6,1/6,1/6,1/6))
# COMMENTARY: The above line executes 40 multinomial trials, with each trial
# consisting of rolling a 6-sided dice 100 times. (that's 40×100=4000 dice
# rolls in total)
D


# The multinomial distribution is FLEXIBLE: we can pick any distribution --
# our dice does not need to be a fair dice. I have a special dice that rolls 6
# slightly more often and 1 slightly less often, which is useful for cheating
# when gambling:
d = rmultinom(1,size=100,prob=c(2/15,1/6,1/6,1/6,1/6,1/5))

# How many times would I need to roll this dice before you are 90% sure that
# I'm cheating? I think the answer is: at least 267 rolls.


## BROWNIAN MOTION

# EXERCISE: Write a function that simulates one-dimensional brownian motion and another function to plot the results.
x1,x2,x3,... with x1 standard normal and x_k = x_{k-1} + e_i where e_i iid normal(0,.000001). Maybe 2-dimensional brownian motion is more interesting

w = rnorm(1000, mean=0, sd=.000001) # generate white nose
x = c() # initialize empty vector
x[1] = w[1] # base case
for(k in 2:1000)
{
  x[k] = x[k-1]+w[k]
}
x
plot(x)



## ## Exercise 1.2 in the textbook

w = c(8.9,7.1,9.1,8.8,10.2,12.4,11.8,10.9,12.7,10.3,8.6,10.7,10.3,8.4,7.7,11.3,7.6,9.6,7.8,10.6,9.2,9.1,7.8,5.7,8.3,8.8,9.2,11.5,10.5,8.8,35.1,8.2,9.3,10.5,9.5,6.2,9.0,7.9,9.6,8.8,7.0,8.7,8.8,8.9,9.4)
hist(w, breaks =37, probability = TRUE)

F <- ecdf(w)
F(10.3)


d = rexp(10, rate = 1/2)
f = round(d,digits=1)
f
2.0 0.8 0.1 2.3 3.2 5.4 2.0 0.4 2.8 3.4
sum(f)

sum((1:6 - 3.5)^2 * (1/6))


# This problem relates to examle 7.1 in the textbook. In lecture, we noted
# that the variance of a sample mean decreases as the size of the sample
# increases. In this problem, we'll visualize that for dice rolls.

# For any positive integer k, the R code

mean(sample(1:6, k, replace=TRUE))

# simulates rolling k 6-sided dice. Write code to compute the sample mean of
# this sample.

# Use the function replicate() to plot histograms consisting of 10000 sample
# means for k=3,10,100, and 1000. When plotting the histograms with the hist()
# function, add the optional argument xlim=c(0,6).
n=10
x = replicate(10000,mean(sample(1:6,n,replace=TRUE)))
hist(x,probability=TRUE,xlim=c(0,6))

curve(dnorm(x,mean = 3.5, sd = sqrt(2.9167/n)), add=TRUE, n=10000)

x=rnorm(100)
help(dnorm)

for (n in c(3,30,60,100,1000,10000,100000,500000,1000000,10000000,100000000)) {
  print(var(sample(1:6, n, replace=TRUE)))
}
35/12


help(ppois)
ppois(0,5)


# chi quared blah

qchisq(.95,6) # returns the value ϕ such that P(Y<ϕ) = .95 (quantile function). Here deg freedom =6
pchisq(12.5916,6) # the cdf of a 6-degree freedom chi-square



## Plotting a histogram of a t-distribution
d = 10 # degrees of freedom for the t-distribution (play around with this)

t_samples = rt(n=100000, df=d)
z_samples = rnorm(n=100000,mean=0,sd=1)

# truncate the datasets to only samples within the range (-6,6). This is
# needed to make the plot pretty.
z_truncated<- z_samples[z_samples >= -6 & z_samples <= 6]
t_truncated<- t_samples[t_samples >= -6 & t_samples <= 6]

# set breaks to be width=.1 between -6 and 6
my_breaks<-seq(-6,6, by=.1)

# Plot the histograms
hist(z_truncated, probability=TRUE, col=rgb(1,0,0,0.4), breaks=my_breaks,
     border="red", main="t-distribution vs standard normal distribution")

hist(t_truncated, probability=TRUE, col=rgb(0,0,1,0.4),
     breaks=my_breaks, border="blue",add=TRUE)

legend("topright",
       legend = c("approx. distribution of Z",
                  paste("approx. t-distribution with df =",degrees_of_freedom)),
       fill=c(rgb(1,0,0,0.4), rgb(0,0,1,0.4)))


# define the cdf F of T
F <- function(x){
  pt(x,df=5)
}

F(2) - F(-2)


qt(.05,df=8,lower.tail = FALSE)
qt(.9,df=5,lower.tail = TRUE)

Q <- function(p){
  qt(p,df=5)
}

Q(.9)
