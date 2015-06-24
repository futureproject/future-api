SITE="http://tfp-redirects-production.herokuapp.com/redirects"
TRIALS=1000
CONCURRENCY=100
ab -n $TRIALS -c $CONCURRENCY $SITE
