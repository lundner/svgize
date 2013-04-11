svgize = () ->

	# the pixelize method creates a rect for every pixel in the original image
	@pixelize = (src, canvasId, svgId, scale) ->
		# create a new image object + get svg and canvas dom element
		img = new Image()
		svg = document.getElementById svgId
		context = document.getElementById(canvasId).getContext '2d'

		# the image was loaded
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
				setSVGAttributes pixel, 
					x: row * scale
					y: line * scale
					width: scale
					height: scale
					fill: color
				svg.appendChild pixel
		img.src = src

	# the gradient method creates a rect for every line filling them with a gradient
	@gradient = (src, canvasId, svgId, scale) ->
		# create a new image object + get svg and canvas dom element
		img = new Image()
		svg = document.getElementById svgId
		# create a defs-element for the gradients
		defs = document.createElementNS 'http://www.w3.org/2000/svg', 'defs'
		svg.appendChild defs
		context = document.getElementById(canvasId).getContext '2d'

		# the image was loaded
		img.onload = () ->

			# set the width and height to the given imagesize times the scale
			svg.setAttribute 'width', img.width * scale
			svg.setAttribute 'height', img.height * scale

			# get the canvas context to draw the image 
			context.drawImage img, 0, 0
			data = context.getImageData(0, 0 , img.width, img.height).data

			# iterate over the pixel 
			# a pixel is described by 4 array slots
			line = -1
			row = 0
			for v,i in data by 4 * scale
				row+= 1 * scale

				# we are reaching the end of the line 
				# -> reset the row and inc the line 
				# + create a rectangle and a gradient
				if (i/4)%img.width == 0
					line += 1 * scale
					row = 0
					ggrad = document.createElementNS 'http://www.w3.org/2000/svg', 'linearGradient'
					setSVGAttributes ggrad,
						id: "gradientLine_#{line}"
						spreadMethod: 'pad'
					defs.appendChild ggrad

					grect = document.createElementNS 'http://www.w3.org/2000/svg', 'rect'
					setSVGAttributes grect,
						x: 0
						y: line
						width: img.width * scale
						height: scale
						fill: "url(#gradientLine_#{line})"
					svg.appendChild grect

				# format the color 
				color = "rgba(#{data[i+0]},#{data[i+1]},#{data[i+2]},#{data[i+3]})"

				# create the svg rectangle and append it 
				gstop = document.createElementNS 'http://www.w3.org/2000/svg', 'stop'
				setSVGAttributes gstop, 
					offset: "#{row*100/img.width}%"
					'stop-color': color
				ggrad.appendChild gstop
		img.src = src

	# a shortcut to set the attributes of svg elements
	setSVGAttributes = (elem, attributes, ns) ->
		ns ?= null
		for k,v of attributes
			elem.setAttributeNS ns, k, v

	return {} =
		pixelize: pixelize
		gradient: gradient

# add it to the global scope
window.svgize ?= svgize()
