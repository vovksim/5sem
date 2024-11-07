matrix_size=(12 100 500 1000 1500 2000 2500 3000)

if [ -f result.csv ]; then
  rm result.csv
fi

echo "MatrixSize, Serial, 4 processes, SpeedUp 4 processes, 16 processes, SpeedUp 16 processes" >> result.csv

serialTime=0
ProcNum4Time=0
ProcNum16Time=0
ProcNum4SpeedUp=0
ProcNum16SpeedUp=0

for i in {0..7}
  do
    #Logging message
    echo "Running serial Matrix-Matrix Size: ${i}."
    #Pipe to redirect matrix size as a input param
    serialTime=$(echo "${matrix_size[i]}" | ./serial_matr_mult)
    #Logging message
    echo "Running parallel Matrix-Matrix Size: ${matrix_size[i]}  ProcNum: 4}."
    #Pipe to redirect matrix size as a input param
    ProcNum4Time=$(echo "${matrix_size[i]}" | mpirun -np 4 parallel_matr_mult)

    echo "Running parallel Matrix-Matrix Size: ${matrix_size[i]}  ProcNum: 16}."
    #Pipe to redirect matrix size as a input param
    ProcNum16Time=$(echo "${matrix_size[i]}" | mpirun --oversubscribe -np 16 parallel_matr_mult)

    ProcNum4SpeedUp=$(echo "scale=3; $serialTime / $ProcNum4Time" | bc -l)
    ProcNum16SpeedUp=$(echo "scale=3; $serialTime / $ProcNum16Time" | bc -l)
    echo "${matrix_size[i]},$serialTime,$ProcNum4Time,$ProcNum4SpeedUp,$ProcNum16Time,$ProcNum16SpeedUp" >> result.csv
  done
