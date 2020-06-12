data {
    int N; //Number of our samples from data
    int deaths[N]; //Our deaths per year from data
    vector[N] Miles;
}

parameters{
    real beta;
}

transformed parameters {
    vector[N] lambda = Miles*beta;
}

model {
    beta ~ beta(2,10);
    deaths ~ poisson(lambda);
}

generated quantities {
    int death[N];
    for (i in 1:N) {
        death[i] = poisson_rng(lambda[i]);
    }

}