//
//  Created by Vlad Vrublevsky on 02.10.2020.
//

#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int last_node = 0;

void endl(int n = 1) {
    /*
     *  Печатает пустые строки. Just for beauty
     */
    for (int i = 0; i < n; ++i) {
        cout << endl;
    }
}


bool existInVector(int value, vector<int> vector) {
    /*
     * Функция проверяет есть ли значение value в векторе vector
     */
    return std::find(vector.begin(), vector.end(), value) != vector.end();
}

vector<int> tree(const int start_node, const vector< vector<int> > matrix, vector<int> path_to_current_node ) {
    vector<int> founded;

    // Добавляем в путь стартовую вершину
    path_to_current_node.push_back(start_node);

    // Получаем строку матрицы, в зависимости от вершины
    vector<int> nodes = matrix.at((start_node - 1) );

    // Проверяем все вершины nodes данного уровня дерева
    for (int i = 0; i < nodes.size(); i++) {
        // Если элемент матрицы равен нулю, пути нет
        if (nodes.at(i) != 0 ) {
            // Если вершина не в пути и является начальной вершиной, то это и есть цикл
            if ((!existInVector(i+1, path_to_current_node)) && (i + 1 == last_node) ) {

                int size = static_cast<int>(path_to_current_node.size());
                founded.push_back(size);

                // Если вершины нет в пути, но она не является начальной вершиной, то начинаем строить
                // дерево от этой вершины, запоминая пройденные вершины
            } else if (!existInVector(i+1, path_to_current_node)) {

                vector<int> p2n_copy = path_to_current_node;
                vector<int> foundedFromNewTree = tree(i+1, matrix, p2n_copy);

                founded.insert(founded.end(), foundedFromNewTree.begin(), foundedFromNewTree.end());

            } else { continue; }
        } else { continue; }

    }
    return founded;
}


int main() {

#ifdef DEBUG
    n = 6;
    vector< vector<int> > matrix = { {0,1,0,0,1,0},
                                     {1,0,1,0,1,0},
                                     {0,1,0,1,0,0},
                                     {0,0,1,0,0,0},
                                     {1,1,0,0,0,0},
                                     {0,0,0,0,0,0} };
#else
    std::cout << "Введите число вершин: ";
    int n;
    std::cin >> n;

    vector< vector<int> > matrix;
    matrix.assign(n, vector<int>(n));

    for (int i = 0; i < n; i++) {

        cout << "Введите массив чисел через пробел: ";
        for (int j = 0; j < n; j++) {
            int num;
            cin >> num;
            matrix.at(i).at(j) = num;
        }

    }
#endif

    endl();

    for (int i = 0; i < n; i++) {
        cout << "[ ";
        for (int j = 0; j < n; j++) {
            cout << matrix.at(i).at(j) << " ";
        }
        cout << "]" << endl;
    }

    endl();

    int start_node;
    cout << "Введите номер начальной вершины: ";
    cin >> start_node;

    int lasted_node;
    cout << "Введите номер конечной вершины: ";
    cin >> lasted_node;

    endl();


    last_node = lasted_node;

    if (start_node == lasted_node) {
        cout << 0 << endl;
    } else {
        vector<int> MoM;
        vector<int> result = tree(start_node, matrix, MoM);

        if (result.size() == 0) {
            cout << "Пути нет" << endl;
        }

        int max = *std::max_element(result.begin(), result.end());
        int min = *std::min_element(result.begin(), result.end());

        cout << "Минимум: " << min << endl;
        cout << "Максимум: " << max << endl;
    }

    return 0;
}
