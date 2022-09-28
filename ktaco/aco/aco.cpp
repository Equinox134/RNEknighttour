#include <iostream>
#include <vector>
#include <set>
#include <random>
#include <cassert>
#include <algorithm>
using namespace std;

struct Edge {
    int end;
    double pheromone, desire;
    Edge(int x, double y, double z) : end(x), pheromone(y), desire(z) {}
};

struct Ant {
    int cnt, loc, sz=0;
    vector<int> path;
    set<int> vis;
    Ant(int n) : cnt(n), path(vector<int>()) {}

    void move(int l) {
        loc = l;
        path.push_back(l);
        vis.insert(l);
        sz++;
    }

    bool canGo(int l) {
        return !vis.count(l);
    }

    bool full() {
        return sz == cnt;
    }
};

vector<Edge> graph[500000];

const int dx[] = { -2,-2,2,2,-1,-1,1,1 };
const int dy[] = { -1,1,-1,1,-2,2,-2,2 };

int n, m, done = 0, wans = 1;
int sx, sy;
double alpha=1.2, beta=1, eva=0.4, Q=10;
vector<int> tour;

random_device rd;
mt19937 gen(rd());

double ChoosePath(Ant& ant) {
    int node = ant.loc;
    vector<double> per;
    vector<Edge> tmp;
    double sum = 0;
    int cnt = 0;
    for (auto i : graph[node]) {
        if (!ant.canGo(i.end)) {
            continue;
        }
        double pher = i.pheromone, des;
        int x = 0;
        for (auto j : graph[i.end]) {
            if (ant.canGo(j.end)) x++;
        }
        if (x > 0) des = 1.0 / x;
        else des = 0.0000001;
        if (!wans) des = 1;
        double k = pow(pher, alpha) * pow(des, beta);
        sum += k;
        per.push_back(k);
        tmp.push_back(i);
        cnt++;
    }
    if (cnt == 0) return -1;
    uniform_real_distribution<> dis(0, sum);
    double rnd = dis(gen);
    //cout << cnt << "cnt\n";
    for (int i = 0; i < cnt; i++) {
        if (rnd < per[i]) {
            assert(i < tmp.size());
            return tmp[i].end;
        }
        rnd -= per[i];
    }
    assert(!"How did you get here?");
}

void evaporate() {
    for (int i = 0; i < n * m; i++) {
        for (auto j : graph[i]) {
            j.pheromone *= 1 - eva;
        }
    }
}

void reset() {
    for (int i = 0; i < n * m; i++) {
        for (auto j : graph[i]) {
            j.pheromone = 1.0;
        }
    }
}

void iterate(Ant& ant) {
    while (!ant.full()) {
        int cur = ant.loc;
        int nxt = ChoosePath(ant);
        //cout << nxt << "\n";
        if (nxt == -1) break;
        ant.move(nxt);
    }
    int s = ant.sz;
    if (s == n * m) {
        done = 1;
        tour = ant.path;
        return;
    }
    evaporate();
    for (int i = s - 2; i >= 0; i--) {
        int tmp = ant.path[i], tmp2 = ant.path[i + 1];
        for (auto& j : graph[tmp]) {
            if (j.end == tmp2) {
                //assert(tmp < graph[tmp2].size());
                //edge jj = graph[tmp2][tmp];
                j.pheromone += Q * (s - (s - i - 1)) / (m * n - 1 - (s - i - 1));
            }
        }
        for (auto& j : graph[tmp2]) {
            if (j.end == tmp) {
                j.pheromone += Q * (s - (s - i - 1)) / (m * n - 1 - (s - i - 1));
            }
        }
    }
}

int main()
{
    cout << "Input Size\n";
    cin >> n >> m;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int k = i * m + j;
            for (int t = 0; t < 8; t++) {
                int nx = i + dx[t], ny = j + dy[t];
                if (nx < 0 || ny < 0 || nx >= n || ny >= m) continue;
                
                int nk = nx * m + ny;
                graph[k].push_back({ nk, 1.0, 1.0 });
            }
        }
    }
    cout << "Input Starting Location\n";
    cin >> sx >> sy;
    if (sx < 0 || sx >= n || sy < 0 || sy >= m) return 0;

    wans = 1;

    int iter = 0;
    //vector<int> test;
    //for (int i = 0; i < 50; i++) {
    //    iter = 0; done = 0;
    //    while (!done) {
    //        Ant ant = Ant(n * m);
    //        ant.move(sx * m + sy);
    //        iterate(ant);
    //        //if (ant.sz >= m * n * 95 / 100) cout << ant.sz << "\n";
    //        if (iter % 10000 == 0) cout << "Check " << iter << "\n";
    //        iter++;
    //    }
    //    test.push_back(iter);
    //    reset();
    //}
    //for (auto i : test) cout << i << "\n";

    while (!done) {
        Ant ant = Ant(n * m);
        ant.move(sx * m + sy);
        iterate(ant);
        if(ant.sz >= m*n*95/100) cout << ant.sz << "\n";
        if (iter % 10000 == 0) cout << "Check " << iter << "\n";
        iter++;
    }
    cout << "iteration: " << iter << "\n";
    for (auto i : tour) cout << i/m << " " << i%m << "\n";
}