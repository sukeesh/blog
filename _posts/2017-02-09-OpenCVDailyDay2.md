---
layout: post
title: "OpenCV Daily : Day 2"
date: 2017-02-09 10:49:20
categories: [sample]
comments: true
---

> **Images are Matrices**

We have an image, which is 300x300 pixels.

![Sanf](/images/posts/opencv/day2/sf.jpg)

Images can be read in Octave using _imread_ function
{% highlight matlab %}
im = imread('sf.jpg');
{% endhighlight %}

Now, let's select the green channel of the above image using the below command
{% highlight matlab %}
imgreen = im(:,:,2);  // ":" represents all the cells in that row/column
{% endhighlight %}

Now, let's see how this image looks.

**Note** : Images are displayed using _imshow()_ function

{% highlight matlab %}
imshow(imgreen);
{% endhighlight %}

![GSanf](/images/posts/opencv/day2/sfg.jpg)

Now, let us see the intensity values of the 300th row using _plot_ in-built function

{% highlight matlab %}
plot(imgreen(300,:));
{% endhighlight %}

![Plot](/images/posts/opencv/day2/plotLine.png)

----------------------------------------------

> **How do we find intensity of a particular pixel/row/column?**

As we know that the image can be represented as matrix, assuming it as an 2D array, we can get the intenisty at xth row, yth column by _im(x, y)_

{% highlight matlab %}
>> disp(im(23,32));
156
{% endhighlight %}

For an entire row,

{% highlight matlab %}
disp(im(23,:));
{% endhighlight %}

For an entire column,

{% highlight matlab %}
disp(im(:,32));
{% endhighlight %}

For rows and columns, the return type is _vector_ of values.

----------------------------------------------

> **Cropping an image**

The size of the image is 300x300. Let's say we want to crop an image of size 100x100 ranging from (100->200)x(200->300)

{% highlight matlab %}
cropped = im(100:200, 200:300);
imshow(cropped);
{% endhighlight %}

![CroppedImage](/images/posts/opencv/day2/crop.png)

---------------------------------------------

> **What do arithmetic operations on images look like?**

**Addition:**

Let's start by adding two images. Pixels in one image gets added to corresponding pixels in other image. Since the two images are of same size, we can just sum two images using "+" operator.

I have loaded a new dolphin image.

{% highlight matlab %}

dol = imread(dl.jpg);
sum = dol + im;
imshow(sum);
{% endhighlight %}

which results in

![Sum](/images/posts/opencv/day2/sum.png)

which looks dirty

That's because when two corresponding intensities of a pixel is maximum ( i.e., 255 ), both adds up to 2 * 255 = 510, Which will be truncated to 255. So, one way to avoid this is by averaging. Something like below.

{% highlight matlab %}

dol = imread(dl.jpg);
avg = dol/2 + im/2;
imshow(avg);
{% endhighlight %}

![Avg](/images/posts/opencv/day2/avg.png)

_Neat!!_

**Subtraction:**

To preserve image difference

{% highlight matlab %}

out = (dol - im) + (im - dol);
{% endhighlight %}

Better way: Use image package

{% highlight matlab %}

pkg load image;

imabsdiff(dl, im); % order doesn't matter
{% endhighlight %}


**Multiply by a scalar:**

Try this yourself.

{% highlight matlab %}

function result = scale(img, value)
	result = value .* img;
endfunction

dolphin = imread('dl.jpg');

imshow(scale(dolphin, 1.5));
{% endhighlight %}

Mutiplying by a value >1 increases the intensity of that picture!

-------------------------------------------------

> **Blending two images**

Let's say we want more of dolphin and less of Golden gate bridge in the picture.

We can do something like this

{% highlight matlab %}
avg = dol * 0.75 + im * 0.25;
imshow(avg);
{% endhighlight %}

Note that weight of dolphin has been increased while that of _im_ has been decreased to maintain the total value of weights to be 1.
This is done because to maintain the same intensity that of original images.

So, in general the function for blending two images will be:

{% highlight matlab %}

% Blend two images
function output = blend(a, b, alpha)
    output = a * alpha + b * ( 1 - alpha );
endfunction
{% endhighlight %}

This method of obtaining the weighted sum of two images is the basis of _alpha-blending_.

------------------------------------------------

> **Noise in images**

- Noise is just another function that is combined with the original function to get a new _guess what_ function

<p align="left"><img align="left" src="https://tex.s2cms.ru/svg/%5Cvec%7BI'%7D(x%2C%20y)%20%3D%20%5Cvec%7BI%7D(x%2C%20y)%20%2B%20%7B%5Cvec%7Bn_%7D%7D%7B(x%2Cy)%7D" alt="\vec{I'}(x, y) = \vec{I}(x, y) + {\vec{n_}}{(x,y)}" /></p>
<p align="center"><img align="center" src="https://tex.s2cms.ru/svg/%7B%5Cvec%7Bn_%7D%7D%7B(x%2Cy)%7D" alt="{\vec{n_}}{(x,y)}" /> is a noise function.</p>

**Common types of noise**

- **Salt and pepper noise**: random occurences of black and white pixels
- **Impulse noise**: random occurences of white pixels
- **Gaussian noise**: variations in intensity drawn from a Gaussian normal distribution

**Gaussian noise**: 

{% highlight matlab %}

noise = randn(size(im)) .*sigma;
output = im + noise;
{% endhighlight %}

