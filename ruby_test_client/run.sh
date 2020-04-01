mkdir resultados

ruby write_1.rb > resultados/01_resultado_write_1
echo "teste write_1 concluído!"
ruby write_string.rb > resultados/02_resultado_write_string
echo "teste write_string concluído!"
ruby write_read_1.rb > resultados/03_resultado_write_read_1
echo "teste write_read_1 concluído!"
# ruby write_read_string.rb > resultados/04_resultado_write_read_string
# echo "teste write_read_string concluído!"

x=1
while [ $x -le  10 ]
do
  ruby multiple_write_read_1.rb --n=10 >> resultados/05_resultado_multiple_write_read_1_10
  x=$(( $x + 1 ))
done

x=1
while [ $x -le 10 ]
do
  ruby multiple_write_read_1.rb --n=20 >> resultados/06_resultado_multiple_write_read_1_20
  x=$(( $x + 1 ))
done

# x=1
# while [ $x -le 10 ]
# do
#   ruby multiple_write_read_1.rb --n=30 >> resultados/07_resultado_multiple_write_read_1_30
#   x=$(( $x + 1 ))
# done

# x=1
# while [ $x -le 10 ]
# do
#   ruby multiple_write_read_1.rb --n=200 >> resultados/08_resultado_multiple_write_read_1_200
#   x=$(( $x + 1 ))
# done

echo "teste multiple_write_read_1 concluído!"

# x=1
# while [ $x -le 10 ]
# do
#   ruby multiple_write_read_string.rb --n=10 >> resultados/09_resultado_multiple_write_read_string_10
#   x=$(( $x + 1 ))
# done

# x=1
# while [ $x -le 10 ]
# do
#   ruby multiple_write_read_string.rb --n=50 >> resultados/10_resultado_multiple_write_read_string_50
#   x=$(( $x + 1 ))
# done

# x=1
# while [ $x -le 10 ]
# do
#   ruby multiple_write_read_string.rb --n=100 >> resultados/11_resultado_multiple_write_read_string_100
#   x=$(( $x + 1 ))
# done

# x=1
# while [ $x -le 10 ]
# do
#   ruby multiple_write_read_string.rb --n=200 >> resultados/12_resultado_multiple_write_read_string_200
#   x=$(( $x + 1 ))
# done

# echo "teste multiple_write_read_string concluído!"