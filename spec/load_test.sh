SITE="http://go.dream.org/widgets/profiles"
SITE="http://localhost:5000/expensive_test"
TRIALS=1000
CONCURRENCY=30
ab -n $TRIALS -c $CONCURRENCY $SITE
