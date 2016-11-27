SITE="http://go.dream.org/directory"
TRIALS=10000
CONCURRENCY=100
ab -n $TRIALS -c $CONCURRENCY $SITE
