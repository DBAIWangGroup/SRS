#!/bin/sh                                                                                                                                                                                                                                                                


echo "== Compiling...  =="
make clean

make all

echo " "
echo "== Calculating parameter =="
./cal_param -n 10000 -m 7

if [ -d "index" ]; then
    rm -r index
fi
mkdir index

echo " "
echo "== Testing using different random seeds =="
for i in 1 2 3 4 5 6 7 8 9 10
do
    #echo " "
    echo "= Test $i ="
    ./srs -I -d 128 -i index/ -m 7 -n 10000 -s hard_data/hard.ds -y f -e $i
    
    #echo " "
    #echo "== Processing query workload... =="
    ./srs -Q -c 4 -g hard_data/hard.gt -i index/ -k 1 -q hard_data/hard.q -t 6 -r 0.299203
done
