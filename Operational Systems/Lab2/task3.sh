for q in {1,5,10,20,50}
do
  for i in {0..99..1}
  do
    ./lottery.py -q "$q" --seed="$i" -l 100:100,100:100 --diff -c > /dev/null
  done
  ./task3_graph.py
  rm stat

  mv task3.png task3_Q"$q".png
done

