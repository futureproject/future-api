SITE="http://go.dream.org/apply"
TRIALS=1000
CONCURRENCY=50
ab -n $TRIALS -c $CONCURRENCY $SITE
