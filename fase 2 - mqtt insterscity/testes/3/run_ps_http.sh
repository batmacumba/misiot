ruby http.rb 100 &
TEST=$!
sleep 5 && ps aux --sort=-pcpu > ps/HTTP
wait $TEST