first_start_node = 0
global_cycles = []
# cycles = []

def get_nodes(node, matrix):
    return matrix[node - 1]

def tree(start_node, matrix, level_of_tree = 0, memory_of_forgetting = []):
    level_of_tree += 1

    if level_of_tree == 1:
        memory_of_forgetting.clear()

    if level_of_tree > 2:
        try: 
            memory_of_forgetting.remove(first_start_node)
        except:
            print("", end = "")
    try:
        memory_of_forgetting.remove(0)
    except:
        print("", end = "")


    memory_of_forgetting.append(start_node)
    # print("-" * 20)
    # print("Вершина: ", start_node)
    # print("Уровень дерева: ", level_of_tree)
    # print("Память забывания: ", memory_of_forgetting)

    nodes = get_nodes(start_node, matrix)

    for i, element in enumerate(nodes):
        if element != 0:
            if ((i + 1) not in memory_of_forgetting) and ((i + 1) == first_start_node):
                # print("Закидываем!")
                memory_of_forgetting.append(first_start_node)
                memory_of_forgetting.sort()
                global_cycles.append(memory_of_forgetting)
                # print(global_cycles)
            elif (i + 1) not in memory_of_forgetting:
                tree(i + 1, matrix, level_of_tree = level_of_tree, memory_of_forgetting = memory_of_forgetting.copy())
            else:
                continue
        else:
            continue

    del memory_of_forgetting

def main():
    out = []
    global global_cycles

    n = int(input("Введите число вершин: "))
    matrix = [list(map(int, input("Введите массив чисел: ").split())) for i in range(n)]

    global first_start_node 

    # start_node = int(input("Введите начальную вершину: "))
    # first_start_node = start_node

    for i in range(1, n + 1): 
        # print("*" * 25 + str(i) + "*" * 25)
        first_start_node = i
        tree(i, matrix)
        # print(len(global_cycles))

    # tree(first_start_node, matrix)
    # print(global_cycles)
    # print(len(global_cycles))

    for massiv in global_cycles:
        yes = ""

        for element in massiv:
            yes += str(element)
        
        out.append(yes)

        print("yes {}".format(yes))

    print("GC {}".format(global_cycles))
    print("out {}".format(out))
    print("set out {}".format(set(out)))
    print("set list out {}".format(list(set(out))))
    out = list(set(out))
    print(len(out))


    
    


if __name__ == "__main__":
    main()
else:
    print("no!")