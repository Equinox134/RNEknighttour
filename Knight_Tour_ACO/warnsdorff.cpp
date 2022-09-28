#include<bits/stdc++.h>
#define trainnum 1000
#define boardx 200
#define boardy 200
using namespace std;

bool start = true;
int value, truecnt = 0, falsecnt = 0, mwaynum;
int chessboard[1001][1001];
int knightx, knighty;
int knightwayx[9] = { -2, -2, -1, -1, 1, 1, 2, 2 };
int knightwayy[9] = { -1, 1, -2, 2, -2, 2, -1, 1 };
int minway[9];

int x, y, count, maxcnt, nextx, nexty;
float a;

void draw(int testnum)
{
    if (start) {

        value = 1;
        maxcnt = 9;
        mwaynum = 0;
        nextx = -1;
        nexty = -1;
        for (int i = 0; i < 8; i++) {

            x = knightwayx[i] + knightx;
            y = knightwayy[i] + knighty;

            if (x < 0 || x >= boardx || y < 0 || y >= boardy || chessboard[x][y] == 1) continue;

            count = 0;
            for (int j = 0; j < 8; j++) {
                int xx, yy;
                xx = knightwayx[j] + x;
                yy = knightwayy[j] + y;

                if (xx < 0 || xx >= boardx || yy < 0 || yy >= boardy || chessboard[xx][yy] == 1) continue;

                count += 1;
            }
            if (count < maxcnt) {
                mwaynum = 1;
                minway[mwaynum] = i;
                maxcnt = count;
            }
            else if (count == maxcnt) {
                mwaynum++;
                minway[mwaynum] = i;
            }
        }
        if (mwaynum == 0) {
            start = false;
        }
        else {
            a = rand() % mwaynum;
            nextx = knightx + knightwayx[minway[(int)a + 1]];
            nexty = knighty + knightwayy[minway[(int)a + 1]];
            chessboard[nextx][nexty] = 1;
            knightx = nextx;
            knighty = nexty;
        }

        //fill(255, 0, 0);
        //rect(knightx*(blockx),knighty*(blocky),blockx,blocky);
    }
}


int main() {
    srand(time(null));
    int trainsum = 0;
    for (int p = 0; p < trainnum; p++) {
        printf("%.3lf%% complete \r", (double)p * (double)100 / (double)trainnum);
        for (int tn = 1;; tn++) {
            knightx = (int)(rand() % boardx);
            knighty = (int)(rand() % boardy);
            chessboard[knightx][knighty] = 1;

            start = true;
            for (int i = 1; i < boardx * boardy; i++) {
                draw(i);
                if (!start) break;
            }
            for (int i = 0; i < boardx; i++) {
                for (int j = 0; j < boardy; j++) {
                    chessboard[i][j] = 0;
                }
            }
            if (start) {
                trainsum += tn;
                break;
            }
        }
    }
    printf("\n");
    printf("%f\n", (float)trainsum / (float)trainnum);
    return 0;
}
