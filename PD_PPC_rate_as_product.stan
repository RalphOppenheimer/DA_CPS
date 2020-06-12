// Passenger deaths - prior predictive checks with rate as product of intensity and miles flown

data {
    int N;
    real Miles[N];
}

generated quantities {
    // beta is our intensity
    // We also use beta distribution because it is in interval 0 to 1 and we dont expect more then 1 dead people per 100 mld miles flown
    // Also its impossible to get - death ratio co 0 limit is perfect for us.
    // Additionally we want to focus rather values around 0,2 then 0,8 that why I decided to use alpha=2 and beta=10 parameters
    real beta = beta_rng(2,10);
    int deaths[N];
    for(i in 1:N) {
        deaths[i] = poisson_rng(Miles[i]*beta);
    }

}