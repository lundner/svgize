svgized
=======

A simple demo that transforms an image pixelwise to svg-rects via canvas. Only use small images (i.e. 100x100px = 10 000 iterations) ;)

if you get the following error: 
> Unable to get image data from canvas because the canvas has been tainted by cross-origin data.

all you need to do is to serve the files with a server. On Mac you can simply start a server by typing 
> python -m SimpleHTTPServer

in the terminal. Now you can access your files over localhost:8000 on your browser.

A demo can be found [here](http://lundner.github.io/svgize/).