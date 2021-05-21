ruby http.rb &
TEST=$!
sleep 5 && ps aux --sort=-pcpu > ps/HTTP
wait $TEST