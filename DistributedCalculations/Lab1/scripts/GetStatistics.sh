
g++ src/serial/SerialMV_1dimension_cstyle.cpp -o serial

mpicxx src/parallel/parallelMV.cpp -o parallel

./serial

mpirun -np 2 parallel
mpirun -np 4 parallel
mpirun -oversubscribe -np 8 parallel

mv serial parallel bin
mv stats.csv stats
