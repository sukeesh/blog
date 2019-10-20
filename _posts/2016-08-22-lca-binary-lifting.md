---
layout: post
title: "Lowest Common Ancestor | Binary Lifting"
author: "Sukeesh"
---

<b>What is LCA?</b>

In graph theory and computer science, the lowest common ancestor (LCA) of two nodes v and w in a tree or directed acyclic graph (DAG) T is the lowest (i.e. deepest) node that has both v and w as descendants, where we define each node to be a descendant of itself (so if v has a direct connection from w, w is the lowest common ancestor).

LCA can be found in _logN_ time with _N * logN_ preprocessing.

---------

Variable | Description
------------- |---------
_L[i]_    | Level of node _i_ 
_P[i]_    | Parent of node _i_
_LCA[i][j]_ | 2<sup>j -th</sup> ancestor of node _i_


----------

## Preprocessing

<b>Finding level and parent of each node using simple dfs</b>

```cpp
void dfs(int node, int par){
    L[node] = L[par] + 1;
    par[node] = par;
    for ( int j = 0 ; j < adj[node].size() ; j ++ ){
        int to = adj[node][j];
        if(to != par) dfs(to, node);
    }
}
```

<b>Filling in LCA array</b>

> Note: Any non negative number can be uniquely represented as a sum of decreasing powers of 2. This is just a variant of binary representation of a number. For number x, there can be at most log2(x) summands

We need to compute `LCA` table. For computing this value we may use following recursion

```cpp
LCA[i][j] = LCA[LCA[i][j-1]][j-1],  if j > 0
----
LCA[i][j] = P[i],  if j = 0
```

if j > 0,<br> _LCA[i][j]_ means 2<sup>j -th</sup> ancestor of node _i_, which is nothing but 2<sup>(j-1) -th</sup> ancestor of node _LCA[i][j-1]_

By using above recursion, we build LCA array as following
```cpp
void ConstructLCA(int n){
    lg = ceil(log2(n));
    int i, j;
    for ( i = 1 ; i <= n ; i ++ ) LCA[i][0] = par[i];

    for ( i = 1 ; i <= lg ; i ++ ) {
        for( j = 1 ; j <= n ; j ++ ) {
            if( LCA[j][i-1] ) {
                LCA[j][i] = LCA[ LCA[j][i-1] ] [i-1];
            }
        }
    }
}
```

## Query

So, for every power j of 2, if `LCA[x][j] != LCA[y][j]` then we know that LCA(x, y) is on a higher level and we will continue searching for `LCA(x = LCA[x][j], y = LCA[y][j])`. At the end, both x and y will have the same father, so return P[x]. Let’s see what happens if `L[x] != L[y]`. Assume, without loss of generality, that L[p] < L[q]. We can use the same meta-binary search for finding the ancestor of p situated on the same level with q, and then we can compute the LCA as described below.

```cpp
int getLca(int x, int y){
    
    if(L[x] < L[y]){
        swap(x, y);
    }

    for(int i=lg; i >= 0; i--){
        if( LCA[x][i] != 0 && L[LCA[x][i]] >= L[y] ){
            x = LCA[x][i];
        }
    }
    
    if( x == y ){
        return x;
    }

    for(int i = lg ; i >= 0 ; i--){
        if( LCA[x][i] != 0 && LCA[x][i] != LCA[y][i] ){
            x = LCA[x][i];
            y = LCA[y][i];
        }
    }

    return LCA[x][0];
}
```

We can observe that this function makes at most `2 * log(H)` operations (H is the height of the tree).



<b>My Implementation in C++</b><br>
[github/sukeesh/Algorithm-Implementations/graphs/LCA/LCAbinarylifting.cpp](https://github.com/sukeesh/Algorithm-Implementations/blame/master/graphs/LCA/LCAbinarylifting.cpp)

<b>Reference</b>
[Topcoder tutorial](https://www.topcoder.com/community/competitive-programming/tutorials/range-minimum-query-and-lowest-common-ancestor/)