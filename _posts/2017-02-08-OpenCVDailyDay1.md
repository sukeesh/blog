---
layout: post
title: "OpenCV Daily : Day 1"
date: 2017-02-08 10:49:20
categories: [sample]
comments: true
---

> **Installing Octave**


*Installation instructions :*

**Arch Linux**

{% highlight shell %}

$ yaourt octave

{% endhighlight %}

*Install required packages for Computer Vision :*

Open Octave and the type in the following command to install Control, General, Image and Signal Packages.

{% highlight shell %}

pkg install -forge general control signal image;

{% endhighlight %}

Once the installation is completed, do

{% highlight shell %}

pkg list;

{% endhighlight %}

You should get the following output

![pkglist](/images/posts/opencv/day1/pkglist.png)

_Now, You are good to go!_



----------------------------------------------------

>**Images as functions Intro**


An image can be thought of as a function *I* of _x_ and _y_ : ***I(x, y)***

We think of an image as a <span style="color:blue">function</span>, _f_ or _I_, from **R<sup>2</sup>** to **R**

<span style="color:blue">f(x, y)</span> gives the intensity or value at position _(x, y)_

Practically define the image over a rectangle, with a finite range 
**_f:[a, b] * [c, d] -> [min, max]_**

_min_ would be blackest of blacks and _max_ would be whitest of whites, If you think of them as intensities.


**Color Images as functions :**

Instead of single intensity as in Black and white, we have one function mapped to three intensities R, G and B.
It's just three functions "stacked" together. 

We can write this as a "vector-valued" function:

$$f(x, y)=\begin{pmatrix}
r(x, y)\\
g(x, y)\\
b(x, y)\\
\end{pmatrix}$$

