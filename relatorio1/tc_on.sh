tc qdisc add dev lo handle 1: root htb
tc class add dev lo parent 1: classid 1:11 htb rate 128kbps 
tc qdisc add dev lo parent 1:11 netem delay 10ms 5ms distribution normal
tc qdisc add dev lo parent 1:11 netem loss 7% 25%