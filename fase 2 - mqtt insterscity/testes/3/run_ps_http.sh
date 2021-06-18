ruby http.rb 20 &
TEST=$!
sleep 5 && ps aux --sort=-pcpu > ps/HTTP
wait $TEST