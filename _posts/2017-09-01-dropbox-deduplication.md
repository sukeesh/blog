---
title: "How Does Dropbox Store Data?"
categories:
  - blog
tags:
  - cloud storage
  - system design
  - architecture
---

It works by breaking files into blocks. Each of these blocks is hashed. Only blocks that are not yet known are uploaded to the server when syncing.

Check : [Dropbox blog](https://blogs.dropbox.com/dropbox/2011/07/changes-to-our-policies/)
### Test

I used this [video](https://www.youtube.com/watch?v=FBCmIFCpJBU) for testing which is `21.8 MB` in size.
The freshly downloaded file took 27 seconds ( approx ) to sync. Then, I renamed the file. This duplicate file took 4 seconds( approx )!

### Video

[![some random](https://img.youtube.com/vi/dDvfkiUxS-A/0.jpg)](https://www.youtube.com/watch?v=dDvfkiUxS-A)