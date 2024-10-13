import numpy as np
from numpy.ma.core import identity

x_marker = ["x1", "x2", "x3", "x4"]

permutation_counter = 0

identity_matrix = [[1, 0, 0],
                   [0, 1, 0],
                   [0, 0, 1]]


def diagonal_m(diagonal_element):
    return 1 / diagonal_element


def column_m(column_element, diagonal_element):
    return -1 * column_element / diagonal_element


def permutation_matrix(matrix_size, max_value_col, working_col):
    global permutation_counter
    result = np.eye(matrix_size)
    result[working_col][working_col] = 0
    result[max_value_col][max_value_col] = 0
    result[working_col][max_value_col] = 1
    result[max_value_col][working_col] = 1

    # If not identity, increase counter
    if np.array_equal(result, identity_matrix):
        permutation_counter += 1

    return result


def m_matrix(matrix, working_row):
    result = np.eye(len(matrix))
    diagonal_element = matrix[working_row][working_row]
    for i in range(working_row, matrix.shape[1]):
        if i == working_row:
            result[i][working_row] = diagonal_m(diagonal_element)
        else:
            result[i][working_row] = column_m(matrix[i][working_row], diagonal_element)
    return result


def find_max_in_col(matrix, working_row):
    col = np.zeros(matrix.shape[0])
    for i in range(working_row, matrix.shape[0]):
        col[i] = matrix[i][working_row]
    max_col_index = np.argmax(col)
    return max_col_index

def inverse_iter(matrix, rs, x_vec):
    result_dic = {}
    for i in reversed(range(matrix.shape[0])):
        value_to_subtract = 0
        for j in range(i + 1, matrix.shape[1]):
            value_to_subtract += result_dic[x_vec[j]] * matrix[i][j]
        result_dic.update({x_vec[i]: rs[i][0] - value_to_subtract})
    return result_dic



matrix_ = np.array([[1, 2, 3],
                    [2, 5, 5],
                    [3, 5, 6]])

matrix_rs = np.array([[1],
                      [2],
                      [3]])

print("Number of columns", matrix_.shape[1])

for i in range(matrix_.shape[1]):
    print("current iteration:", i)
    print("Current matrix:", "\n", matrix_, "\n")

    swap_with = find_max_in_col(matrix_, i)
    permutation = permutation_matrix(matrix_.shape[1], swap_with, i)

    print("P", "\n", permutation, "\n")
    matrix_ = np.matmul(permutation, matrix_)
    matrix_rs = np.matmul(permutation, matrix_rs)
    print("Current matrix:", "\n", matrix_, "\n")

    print("right side perm", "\n", matrix_rs, "\n")


    print("Current matrix before M:", "\n", matrix_, "\n")

    m_matr = m_matrix(matrix_, i)
    print("M", "\n", m_matr, "\n")


    matrix_ = np.matmul(m_matr, matrix_)
    print("Current matrix after M:", "\n", matrix_, "\n")
    matrix_rs = np.matmul(m_matr, matrix_rs)
    print("right side", "\n", matrix_rs, "\n")

print(inverse_iter(matrix_, matrix_rs, x_marker))