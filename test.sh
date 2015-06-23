SITE="http://tfp-rb-test.herokuapp.com/"
TRIALS=5000
CONCURRENCY=100
ab -n $TRIALS -c $CONCURRENCY $SITE
