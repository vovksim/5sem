for i in {0..99..1}
do
  ./lottery.py -s "$i" -l 10:1,10:100 -c --diff > /dev/null
done

./task3_graph.py

rm stat

mv task3.png task2.png
