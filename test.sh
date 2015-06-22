SITE="http://tfp-rb-test.herokuapp.com/"
TRIALS=1000
CONCURRENCY=100
ab -n $TRIALS -c $CONCURRENCY $SITE
