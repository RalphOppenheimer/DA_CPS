
functions {
	// Difference between one-sided Gaussian tail probability and target probability
	vector tail_delta(vector y, vector theta, real[] x_r, int[] x_i) {

		//The *tail_delta* function takes a vector of values "y" and vector of
		//parameters "theta" to be optimized

		//*real[] x_r, int[] x_i* are "testing values" whatever that means, and
		//why they are denoted that way...

		vector[1] deltas; //we are declaring vector with it's size. (like in C)
    //In stan, value indexation starts at 1. (like in matlab).
		deltas[1] = 2 * (normal_cdf(theta[1], 0, exp(y[1])) - 0.5) - 0.99;

		//"normal_cdf" stands for "cumulative distribution function"
    //for *normal distribution. It has parameters:
		//(<x-axis variable>, <expected value>, <standard deviation>).
    //The output is calculated for <x-axis variable>.
		//The standard deviation has an exponent value
		//because of computational reasons - (basically *normal_cdf* operates that way)

		return deltas;
	}
}

data {
	vector[1] y_guess; // Initial guess of Gaussian standard deviation:
  //(algebra solver must have an initial guess to work properly)
	vector[1] theta;   //std deviation to which the distribution is derived
}

transformed data {

	vector[1] y;
	real x_r[0];
	int x_i[0];

	// Find Gaussian standard deviation that ensures 99% probabilty below 15
	y = algebra_solver(tail_delta, y_guess, theta, x_r, x_i);
  //Again, the solution is in a form of logarithm, so exp() is necessary.
	print("Standard deviation = ", exp(y[1]));
}

generated quantities {
	real sigma = exp(y[1]);
}
