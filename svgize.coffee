window.svgize ?= (src, canvasId, svgId, scale) ->

	# create a new image object + get svg and canvas dom element
	img = new Image()
	svg = document.getElementById svgId
	context = document.getElementById(canvasId).getContext '2d'

	# the image was successfully loaded
	img.onload = () ->

		# set the width and height to the given imagesize times the scale
		svg.setAttribute 'width', img.width*scale
		svg.setAttribute 'height', img.height*scale

		# get the canvas context to draw the image 
		context.drawImage img, 0, 0
		data = context.getImageData(0, 0 , img.width, img.height).data

		# iterate over the pixel 
		# a pixel is described by 4 array slots
		line = -1
		row = 0
		for v,i in data by 4
			row+=1
			
			# we are reaching the end of the line 
			# -> reset the row and inc the line 
			if (i/4)%img.width == 0
				line += 1
				row = 0

			# format the color 
			color = "rgba(#{data[i+0]},#{data[i+1]},#{data[i+2]},#{data[i+3]})"
			
			# create the svg rectangle and append it 
			pixel = document.createElementNS 'http://www.w3.org/2000/svg', 'rect'
			pixel.setAttributeNS null, 'x', row*scale
			pixel.setAttributeNS null, 'y', line*scale
			pixel.setAttributeNS null, 'width', scale
			pixel.setAttributeNS null, 'height', scale
			pixel.setAttributeNS null, 'fill', color
			svg.appendChild pixel

	img.src = src
	return