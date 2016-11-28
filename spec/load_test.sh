SITE="http://go.dream.org/less_expensive_test"
TRIALS=1000
CONCURRENCY=30
ab -n $TRIALS -c $CONCURRENCY $SITE
