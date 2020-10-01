#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int last_node = 0;

void endl(int n = 1) {
    for (int i = 0; i < n; ++i) {
        cout << endl;
    }
}

vector<int> get_nodes(int node, vector< vector<int> > matrix) {
    vector<int> result = matrix.at((node - 1) );
    return result;
}

bool existInMOM(int value, vector<int> MoM) {
    return std::find(MoM.begin(), MoM.end(), value) != MoM.end();
}

vector<int> tree(const int start_node, const vector< vector<int> > matrix, vector<int> memory_of_forgetting ) {
    vector<int> founds;

    try {
        if (memory_of_forgetting.size() > 0) {
            memory_of_forgetting.erase(memory_of_forgetting.begin(), memory_of_forgetting.begin() + 1);
        }

    } catch (int a) { }

    memory_of_forgetting.push_back(start_node);


    vector<int> nodes = matrix.at((start_node - 1) );//get_nodes(start_node, matrix);

    for (int i = 0; i < nodes.size(); i++) {
        if (nodes.at(i) != 0 ) {
            if ( (!existInMOM(i+1, memory_of_forgetting))  && (i+1 == last_node) ) {
                int size = static_cast<int>(memory_of_forgetting.size());
                founds.push_back(size);
            } else if (!existInMOM(i+1, memory_of_forgetting)) {
                vector<int> newMoM = memory_of_forgetting;

                vector<int> foundsNew = tree(i+1, matrix, newMoM);
                for (int i = 0; i < foundsNew.size(); i++) {
                    founds.push_back(foundsNew.at(i));
                }
            } else { continue; }
        } else { continue; }

    }
    return  founds;
}


int main() {

    std::cout << "Введите число вершин: ";
    int n;
    std::cin >> n;


    n = 6;

    vector< vector<int> > matrix = { {0,1,0,0,1,0},
                                     {1,0,1,0,1,0},
                                     {0,1,0,1,0,0},
                                     {0,0,1,0,0,0},
                                     {1,1,0,0,0,0},
                                     {0,0,0,0,0,0} };


/*
 *  vector< vector<int> > matrix = { {0, 1, 0, 1},
                                     {0, 0, 1, 1},
                                     {0, 1, 0, 0},
                                     {1, 0, 1, 0} };
 *
 *
    vector< vector<int> > matrix;
    matrix.assign(n, vector<int>(n));


    for (int i = 0; i < n; i++) {

        cout << "Введите массив чисел: ";

        for (int j = 0; j < n; j++) {
            int num;
            cin >> num;
            matrix.at(i).at(j) = num;
            //matrix[i][j] = num;
        }

    }

    */


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

        for (int i = 0; i < result.size(); ++i) {
            cout << result.at(i);
        }
    }

    return 0;
}
