SITE="http://go.dream.org/directory"
TRIALS=10000
CONCURRENCY=200
ab -n $TRIALS -c $CONCURRENCY $SITE
