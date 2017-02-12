---
layout: post
title: "OpenCV, Gaussian Noise"
date: 2017-02-10 10:49:20
categories: [sample]
comments: true
---

> **Generate Gaussian noise**

A Gaussian distribution has a probability distribution function.

The center or mean, for 'randn' is zero, and the standard deviation is one. The standard deviation is a measure of how spread out the distribution is.

Thus, We use 'randn' function to generate a gaussian noise.

Let's take a look at how different random functions ('randn', 'rand', 'randi') plot looks like

![randn](/images/posts/opencv/day3/randn.png)
![rand](/images/posts/opencv/day3/rand.png)
![randi](/images/posts/opencv/day3/randi.png)

> **Effect of sigma of Gaussian noise**

We know that 

{% highlight matlab %}
noise = randn(size(im)).*sigma;
{% endhighlight %}

By increasing sigma, more and more noise is being added to the image.

> **Applying noise to image**

{% highlight matlab %}
img = imread('hyd.jpg');
imshow(img);

noise = randn(size(img)) .* 50;
output = img + noise;
imshow(output);
{% endhighlight %}

**Before:**

<img src="/images/posts/opencv/day3/hyd.jpg" height="300" width="440">

**After:**

![ghyd](/images/posts/opencv/day3/ghyd.png)


_That's it for the day!_
