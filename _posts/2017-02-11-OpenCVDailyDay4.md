---
layout: post
title: "OpenCV, Intro to smoothing"
date: 2017-02-11 08:40:00
categories: [sample]
comments: true
---

> **An introduction to smoothing**

**Averaging assumptions**

- The true value of pixels are similar to the true value pixels nearby.
- The noise added to each pixel is done independently.

**Weighted Moving Average**

The more nearby a pixel is, the more related it is. Using Non-uniform weights smoothens the curve.

**Moving average in 2D ( images )**

- **Correlation filtering - uniform weights**

Say the averaging window size is (2k+1)*(2k+1)

<p align="center"><img align="center" src="https://tex.s2cms.ru/svg/G%5Bi%2Cj%5D%20%3D%20%7B1%5Cover%7B(2k%2B1)%5E2%7D%7D%7B%5Csum_%7Bu%3D-k%7D%5E%7Bk%7D%7D%7B%5Csum_%7Bv%3D-k%7D%5E%7Bk%7D%7D%7BF%5Bi%2Bu%2Cj%2Bv%5D%7D" alt="G[i,j] = {1\over{(2k+1)^2}}{\sum_{u=-k}^{k}}{\sum_{v=-k}^{k}}{F[i+u,j+v]}" /></p>

- **Correlation filtering - nonuniform weights**

Now generalize to allow different weights depending on neighbouring pixel's relative position:

<p align="center"><img align="center" src="https://tex.s2cms.ru/svg/G%5Bi%2Cj%5D%20%3D%20%7B1%5Cover%7B(2k%2B1)%5E2%7D%7D%7B%5Csum_%7Bu%3D-k%7D%5E%7Bk%7D%7D%7B%5Csum_%7Bv%3D-k%7D%5E%7Bk%7D%7D%7BH%5Bu%2C%20v%5D%7D%7BF%5Bi%2Bu%2Cj%2Bv%5D%7D" alt="G[i,j] = {1\over{(2k+1)^2}}{\sum_{u=-k}^{k}}{\sum_{v=-k}^{k}}{H[u, v]}{F[i+u,j+v]}" /></p>

This is called **cross-correlation**, denoted by 
<p align="center"><img align="center" src="https://tex.s2cms.ru/svg/G%20%3D%20%7BH%5Cotimes%20F%7D" alt="G = {H\otimes F}" /></p>

The filter **kernel** or **mask** H[u,v] is the matrix of weights in the linear combination.

**Note :** To blur a single pixel into a "blurry" spot, we would need to filter the spot with higher values in the middle, falling off to the edges.

----------------------------------------------------

> **Gaussian filter**

- Nearest neighbouring pixels have the most influence

The _kernel_ is an approximation of a Gaussian function:

<p align="center"><img align="center" src="https://tex.s2cms.ru/svg/%7Bh(u%2Cv)%7D%20%3D%20%7B1%5Cover2%5Cpi%5Csigma%5E2%7D%7D%20%7Be%5E%7B%7B-(u%5E2%2Bv%5E2)%7D%7D%5Cover%20%5Csigma%5E2%7D%7D" alt="{h(u,v)} = {1\over2\pi\sigma^2}} {e^{{-(u^2+v^2)}}\over \sigma^2}}" /></p>

Smoothing with Gaussian filter vs Non Gaussian filter

![im1](/images/posts/opencv/day4/gaussian.png)
![im2](/images/posts/opencv/day4/non.png)

In non-Gaussian, we can see sharp pixels. whereas, Guassian is smoooth!

**Variance or standard deviation** determines extent of smoothing. Size of kernel is not variance.

----------------------------------------------------

> **MATLAB**

{% highlight matlab %}
hsize = 31;
sigma = 5;

pkg load image;
h = fspecial('gaussian', hsize, sigma);
surf(h);
{% endhighlight %}

![surf](/images/posts/opencv/day4/fspecial.png)

{% highlight matlab %}
imagesc(h);
{% endhighlight %}

![imagesc](/images/posts/opencv/day4/imagesc.png)

{% highlight matlab %}
im = imread('panda.jpg');
{% endhighlight %}

<img src="/images/posts/opencv/day4/panda.jpg" height="160" width="236">

{% highlight matlab %}
outim = imfilter(im, h);
imshow(outim);
{% endhighlight %}

![bim](/images/posts/opencv/day4/blurpanda.png)

and again, depending on the size of the sigma we get different amounts of smoothing. More is the sigma, more is the smoothing!

{% highlight matlab %}
% Apply a Gaussian filter to remove noise

img = imread('panda.jpg');
imshow(img);

noise_sigma = 32;

noise = randn(size(img)).*noise_sigma;
nimg = img + noise;

imshow(nimg);

% Now apply a Gaussian filter to smooth out the noise

pkg load image;

hsize = 25;
sigma = 3;

h = fspecial('gaussian', hsize, sigma);

outim = imfilter(nimg, h);
imshow(outim);
{% endhighlight %}

**Note:**

When filtering with a Gaussian,
- The sigma is most important - it defines the blur kernel's scale with respect to the image.
- Altering the normalization coefficient does not effect the blur, only the brightness.

**Alright!!**