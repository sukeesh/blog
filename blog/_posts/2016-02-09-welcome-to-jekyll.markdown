---
layout: post
title:  "Welcome to Jekyll!"
date:   2016-02-09 18:01:24
categories: jekyll update
---
You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

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

Check out the [Jekyll docs][jekyll] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll’s dedicated Help repository][jekyll-help].

[jekyll]:      http://jekyllrb.com
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-help]: https://github.com/jekyll/jekyll-help
