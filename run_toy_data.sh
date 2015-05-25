#!/bin/sh


echo "== Compiling...  =="
make clean

make all

echo " "
echo "== Calculating parameter =="
./cal_param -n 3000 -m 7

echo " "
echo "== Generating ground truth =="
./gen_gt -d 192 -n 3000 -k 10 -q data/toy.q -s data/toy.ds -g data/toy.gt -y i

if [ -d "index" ]; then
    rm -r index
fi
mkdir index

echo " "
echo "== Indexing... =="
./srs -I -d 192 -i index/ -m 7 -n 3000 -s data/toy.ds 

echo " "
echo "== Processing query workload... =="
./srs -Q -c 4 -g data/toy.gt -i index/ -k 10 -q data/toy.q -t 2 -r 0.299203
