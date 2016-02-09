---
layout: post
title:  "First Jekyll Post"
date:   2016-02-09 18:36:24
categories: new-post
---

Now, finally my blog is Jekyll Powered. Easy to post :) .
It's easy to add code snippets,

{% highlight cpp %}
#include <bits/stdc++.h>
using namespace std;

#define ll long long
#define ld long double
#define inf 1000000000
#define eps 1e-9
#define all(a)   a.begin(),a.end()
#define mp make_pair
#define ff first
#define ss second
#define pb push_back
#define sz size()
#define mod 1000000007
#define sl(inp) scanf("%lld",&inp)
#define sd(inp) scanf("%d",&inp)
#define rep(i, a, b) for(int i = a; i < b ; ++i)



int main()
{
    ld d, L, v1, v2, v;
    cin >> d >> L >> v1 >> v2 ;
    v = v1+v2;
    ld ans = 0.00;
    ans = (L-d)*1.0;
    ans = ans/(1.0*v);
    cout << fixed << setprecision(6) << ans << endl;
    // printf("%.6Lf",ans);
	return 0;
}
{% endhighlight %}

and lot many features!!

[jekyll]:      http://jekyllrb.com
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-help]: https://github.com/jekyll/jekyll-help
