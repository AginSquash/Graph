last_node = 0

def tree(start_node, matrix, path_to_current_node):
    founded = []


    # Добавляем в путь стартовую вершину
    path_to_current_node.append(start_node)

    # Получаем строку матрицы, в зависимости от вершины
    nodes = matrix[start_node - 1] 

    # Проверяет все вершины nodes данного уровня дерева
    for i, element in enumerate(nodes):
        # Если элемент матрицы равен нулю, пути нет
        if element != 0:
            # Если вершина не в пути и является начальной вершиной, то это и есть цикл
            if ((i + 1) not in path_to_current_node) and ((i + 1) == last_node):

                # Для дебага
                # print("P2N: " + str(path_to_current_node))
                # print("len: " + str(len(path_to_current_node)))

                founded.append(len(path_to_current_node))  

            # Если вершины нет в пути, но она не является начальной вершиной, то начинаем строить
            # дерево от этой вершины, запоминая пройденные вершины
            elif (i + 1) not in path_to_current_node:
                founded += tree(i + 1, matrix, path_to_current_node.copy())
            else:
                continue
        else:
            continue

    return founded

def main():
    n = int(input("Введите число вершин: "))

    matrix = []

    for _ in range(0, n):
       row = map(int, input("Введите массив чисел: ").split())
       matrix.append(list(row))

    for row in matrix:
        print(row)
        
    start_node = int(input("Введите номер начальной вершины: "))
    lasted_node = int(input("Введите номер конечной вершины: "))

    global last_node
    last_node = lasted_node

    if start_node != lasted_node:
        temp_list = list([0])
        temp_list.remove(0)
        result = tree(start_node, matrix, temp_list.copy())

        if len(result) > 0:
            print("Минимум: ", min(result), "Максимум: ", max(result))
        else: 
            print("Пути не существует!")



if __name__ == "__main__":
    main()