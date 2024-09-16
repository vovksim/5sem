#include <vector>
#include <iostream>


std::vector<std::vector<int>> matrix { {0,1,1},
                                       {0,0,1},
                                       {0,0,0}};

std::vector<int> visited(3);



bool is_cyclic(int v) {
    if(visited[v] == 1) 
      return true;
    visited[v]=1;
    for(int i=0; i < matrix[v].size(); i++) { 
      if(matrix[v][i]==1 and visited[i]==0) {
       if(is_cyclic(i))
          return true;
       }
    }
    visited[v]=2;
    return false;
}




int main() {
    if(is_cyclic(0))
      std::cout << "Cycle" << std::endl;
    else
      std::cout << "no cycle" << std::endl;
    return 0;
}


