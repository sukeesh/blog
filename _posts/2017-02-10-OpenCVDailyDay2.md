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
{% highlight octave %}
>> im = imread('sf.jpg');
{% endhighlight %}

Now, let's select the green channel of the above image using the below command
{% highlight octave %}
>> imgreen = im(:,:,2);  // ":" represents all the cells in that row/column
{% endhighlight %}

Now, let's see how this image looks.

**Note** : Images are displayed using _imshow()_ function

{% highlight octave %}
>> imshow(imgreen);
{% endhighlight %}

![GSanf](/images/posts/opencv/day2/sfg.jpg)

Now, let us see the intensity values of the 300th row using _plot_ in-built function

{% highlight octave %}
>> plot(imgreen(300,:));
{% endhighlight %}

![Plot](/images/posts/opencv/day2/plotLine.png)

----------------------------------------------

> **How do we find intensity of a particular pixel/row/column?**

As we know that the image can be represented as matrix, assuming it as an 2D array, we can get the intenisty at xth Row, yth column by _im(x, y)_

{% highlight octave %}
>> disp(im(23,32));
156
{% endhighlight %}

For an entire row,

{% highlight octave %}
>> disp(im(23,:));
{% endhighlight %}

For an entire column,

{% highlight octave %}
>> disp(im(:,32));
{% endhighlight %}

For rows and columns, the return type is _vector_ of values.

----------------------------------------------

> **Cropping an image**

The size of the image is 300x300. Let's say we want to crop an image of size 100x100 ranging from (100->200)x(200->300)

{% highlight octave %}
>> cropped = im(100:200, 200:300);

>> imshow(cropped);
{% endhighlight %}

![CroppedImage](/images/posts/opencv/day2/crop.png)

---------------------------------------------

> **What do arithmetic operations on images look like?**

Let's start by adding two images. Pixels in one image gets added to corresponding pixels in other image. Since the two images are of same size, we can just sum two images using "+" operator,

I have loaded a new dolphin image.

{% highlight octave %}

>> dol = imread(dl.jpg);
>> sum = dol + im;
>> imshow(sum);
{% endhighlight %}

which results in

![Sum](/images/posts/opencv/day2/sum.png)

which looks dirty

That's because when two corresponding intensities of a pixel is maximum ( i.e., 255 ), both adds up to 2 * 255 = 510, Which will be quantized to 255. So, one way to avoid this is by averaging. Something like below.

{% highlight octave %}

>> dol = imread(dl.jpg);
>> avg = dol/2 + im/2;
>> imshow(avg);
{% endhighlight %}

![Avg](/images/posts/opencv/day2/avg.png)

**Neat!**