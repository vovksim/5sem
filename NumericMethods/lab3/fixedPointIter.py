import numpy as np

#Формуємо Якобіан
def jacobian(x:float,y:float):
  return np.array([(0, -np.sin(y)/3),(np.cos(x-0.6),0)])

def fi_x(x,y):
  return (np.cos(y)+0.9)/3+x*0

def fi_y(x,y):
  return np.sin(x-0.6)-1.6+y*0

initial_guess = np.array([0.601,20])

#Перевіряємо умову збіжності
if np.linalg.norm(jacobian(initial_guess[0],initial_guess[1]),np.inf) > 1:
  print(np.linalg.norm(jacobian(initial_guess[0],initial_guess[1]),ord=np.inf))
  raise RuntimeError("Convergence check failed!")

epsilon = 0.00001

iteration_counter=1
previous_sol = initial_guess
while(True):
  current_sol = np.array([fi_x(previous_sol[0],previous_sol[1]),fi_y(previous_sol[0],previous_sol[1])])
  print(f"Iter #{iteration_counter}","Current: x:", current_sol[0], "y:", current_sol[1], " Previous: x:", previous_sol[0], "y:", previous_sol[1])
  if np.max(np.abs(current_sol-previous_sol)) < epsilon or iteration_counter > 25:
    break
  previous_sol = current_sol
  iteration_counter+=1

print("\n\nRESULT:", "x:", current_sol[0], "\ty:", current_sol[1])

