---
layout: post
title: "OpenCV, Linearity and Convolution"
date: 2017-02-12 09:49:20
categories: [sample]
comments: true
---

**Impulse function**

- In the discrete world, an _impulse_ is a very easy signal to understand: it's just a value of 1 at a single location.
- In continous world, an _impulse_ is an idealized function that is very narrow and very tall so that it has a unit area.

**Impulse response**

- If I have an unknown system and I "put in" an impulse, the response is called the impulse response.

**Convolution**

<p align="center"><img align="center" src="https://tex.s2cms.ru/svg/G%5Bi%2Cj%5D%20%3D%20%7B1%5Cover%7B(2k%2B1)%5E2%7D%7D%7B%5Csum_%7Bu%3D-k%7D%5E%7Bk%7D%7D%7B%5Csum_%7Bv%3D-k%7D%5E%7Bk%7D%7D%7BH%5Bu%2C%20v%5D%7D%7BF%5Bi-u%2Cj-v%5D%7D" alt="G[i,j] = {1\over{(2k+1)^2}}{\sum_{u=-k}^{k}}{\sum_{v=-k}^{k}}{H[u, v]}{F[i-u,j-v]}" /></p>

(Flip in both dimensions)

This is called Convolution, **denoted** by:

<p align="center"><img align="center" src="https://tex.s2cms.ru/svg/G%20%3D%20%7BH%20*%20F%7D" alt="G = {H * F}" /></p>

Difference between Cross-correlation and Convolution matters only when the filter is asymmetric.

**Shift Invariant**

- Operator behaves the same everywhere, i.e. the value of the output depends on the pattern in the image neighbourhood, not the position of the neighbourhood

**Properties of convolution**

- Linear & Shift Invariant
- Commutative, _f * g = g * f_
- Associative, _(f * g) * h = f * (g * h)_
- Identity, 
      unit inpulse e = [..., 0, 0, 1, 0, 0, ...]. f * e = f

**Computational complexity**

- If an image is NxN and a kernel is WxW, you need N*N*W*W.

**Seperability**

- In some cases, filter is seperable, meaning you can get the square kernel H by convolving a single column vector by some row vector. c * r = H.

G = H * F = (C * R) * F = C * (R * F).

So, we do two convolutions but each is W * N * N. So this is useful if W is big enough such that 2 * W * N * N << W * W * N * N
