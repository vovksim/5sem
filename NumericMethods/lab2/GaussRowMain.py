import numpy as np

matrix_2 = np.array([[1, 2, 3],
                     [2, 5, 5],
                     [3, 5, 6]])

matrix_ = np.array([[1, 2, -4, 2],
                    [-2, 5, 3, -1],
                    [2, 1, -1, 2],
                    [3, 1, -2, -1]])

matrix_rs_2 = np.array([[1],
                        [2],
                        [3]])

matrix_rs = np.array([[6],
                      [2],
                      [2],
                      [3]])

permutation_counter = 0

diagonal_elements = np.zeros(matrix_.shape[0])

identity_matrix = np.eye(matrix_.shape[0])

x_marker = ["x" + str(i+1) for i in range(matrix_.shape[0])]


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
    if not np.array_equal(result, identity_matrix):
        x_marker[max_value_col], x_marker[working_col] = x_marker[working_col], x_marker[max_value_col]
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


def find_max_in_col(matrix, working_col):
    row = np.zeros(matrix.shape[0])
    for i in range(working_col, matrix.shape[0]):
        row[i] = matrix[i][working_col]
    max_col_index = np.argmax(row)
    return max_col_index


def inverse_iter(matrix, rs, x_vec):
    result_dic = {}
    for i in reversed(range(matrix.shape[0])):
        value_to_subtract = 0
        for j in range(i + 1, matrix.shape[1]):
            value_to_subtract += result_dic[x_vec[j]] * matrix[i][j]
        result_dic.update({x_vec[i]: rs[i][0] - value_to_subtract})
    return result_dic


def calc_determinant(permutation_counter, main_element):
    det = 1
    for i in range(main_element.shape[0]):
        det *= main_element[i]
    det *= -1 ** (permutation_counter)
    return det


for i in range(matrix_.shape[1]):
    print("Current iteration:", i)

    # Finding column to be swapped and creating the P matrix
    swap_with = find_max_in_col(matrix_, i)
    permutation = permutation_matrix(matrix_.shape[1], swap_with, i)

    print("P", "\n", permutation, "\n")

    # transforming
    matrix_ = np.matmul(matrix_, permutation)

    # remember the main elements for determinant
    diagonal_elements[i] = matrix_[i][i]

    # creating M matrix
    m_matr = m_matrix(matrix_, i)
    print("M", "\n", np.round(m_matr, 2), "\n")

    # nulling elemnts under working one
    matrix_ = np.matmul(m_matr, matrix_)

    print("Current equation:", "\n", np.round(matrix_, 2), "\n", x_marker, "\n")

    # transforming the right side vector
    matrix_rs = np.matmul(m_matr, matrix_rs)
    print("right side", "\n", np.round(matrix_rs, 2), "\n")

# printing results
print(inverse_iter(matrix_, matrix_rs, x_marker), "\n")

# displating number of permutations
print("Matrix was transformed:", permutation_counter, "times.", "\n")

# calculating determinant with remembered diagonal elements
print("Determinant:", calc_determinant(permutation_counter, diagonal_elements))

# obumovlenosti
print("Conditional", np.linalg.norm(np.linalg.inv(matrix_)) * np.linalg.norm(matrix_), "\n")
