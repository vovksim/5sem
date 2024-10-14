import numpy
import numpy as np

A = np.array([[5, 2, -1],
              [-4, 7, 3],
              [2, -2, 4]])

b = np.array([[12],
              [24],
              [9]])

initial_guess = np.zeros(3)
for i in range(b.shape[0]):
    initial_guess[i] = b[i][0]/A[i][i]


def check_convergence(matrix):
    for i in range(matrix.shape[0]):
        sum = 0
        for j in range(matrix.shape[1]):
            if j!=i:
                sum += np.abs(matrix[i][j])
        if np.abs(matrix[i][i]) < sum:
            raise "Jacobi method will diverge."

def jacobi_init(initial_matrix, rs):
    jacobi_initial_form = numpy.empty([3, 4])
    for i in range(0, initial_matrix.shape[0]):
        #ділимо на елемент головної діагоналі
        #таким чином виражаємо відповідні х
        arr = numpy.array(-initial_matrix[i] / initial_matrix[i][i])
        arr[i] = 0
        arr = numpy.append(arr, rs[i] / initial_matrix[i][i])
        jacobi_initial_form[i] = arr
    return jacobi_initial_form

#підставляємо відповідні х у вирази
def iteration(initial_form, values):
    return np.dot(initial_form, values)

#перевіримо умову збіжності
check_convergence(A)

#вирази для х
initial_jacobi_form = jacobi_init(A, b)


current_x = initial_guess
previous_x = np.zeros(3)
while np.abs(current_x - previous_x).max() > 0.0001:
    temp = iteration(initial_jacobi_form, np.append(current_x, 1))
    previous_x = current_x
    current_x = temp
print(current_x)
