// Passenger deaths - prior predictive checks
generated quantities {
    // During prior prediction we shouldn't look to data but we don't have to much knowledge about how many people die per year in plane accidents
    // So I decided to use mean value of deaths from data and select wide sigma to catch all possibilities
    real lambda = normal_rng(692,200);
    int deaths = poisson_rng(lambda);
}