// Generated by CoffeeScript 1.6.2
(function() {
  var _ref;

  if ((_ref = window.svgize) == null) {
    window.svgize = function(src, canvasId, svgId, scale) {
      var setSVGAttributes;

      setSVGAttributes = function(elem, attributes, ns) {
        var k, v, _results;

        if (ns == null) {
          ns = null;
        }
        _results = [];
        for (k in attributes) {
          v = attributes[k];
          _results.push(elem.setAttributeNS(ns, k, v));
        }
        return _results;
      };
      this.pixelize = function() {
        var context, img, svg;

        img = new Image();
        svg = document.getElementById(svgId);
        context = document.getElementById(canvasId).getContext('2d');
        img.onload = function() {
          var color, data, i, line, pixel, row, v, _i, _len, _results;

          svg.setAttribute('width', img.width * scale);
          svg.setAttribute('height', img.height * scale);
          context.drawImage(img, 0, 0);
          data = context.getImageData(0, 0, img.width, img.height).data;
          line = -1;
          row = 0;
          _results = [];
          for (i = _i = 0, _len = data.length; _i < _len; i = _i += 4) {
            v = data[i];
            row += 1;
            if ((i / 4) % img.width === 0) {
              line += 1;
              row = 0;
            }
            color = "rgba(" + data[i + 0] + "," + data[i + 1] + "," + data[i + 2] + "," + data[i + 3] + ")";
            pixel = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
            setSVGAttributes(pixel, {
              x: row * scale,
              y: line * scale,
              width: scale,
              height: scale,
              fill: color
            });
            _results.push(svg.appendChild(pixel));
          }
          return _results;
        };
        return img.src = src;
      };
      this.gradient = function() {
        var context, defs, img, svg;

        img = new Image();
        svg = document.getElementById(svgId);
        defs = document.createElementNS('http://www.w3.org/2000/svg', 'defs');
        svg.appendChild(defs);
        context = document.getElementById(canvasId).getContext('2d');
        img.onload = function() {
          var color, data, ggrad, grect, gstop, i, line, row, v, _i, _len, _ref1, _results;

          svg.setAttribute('width', img.width * scale);
          svg.setAttribute('height', img.height * scale);
          context.drawImage(img, 0, 0);
          data = context.getImageData(0, 0, img.width, img.height).data;
          line = -1;
          row = 0;
          _ref1 = 4 * scale;
          _results = [];
          for ((_ref1 > 0 ? (i = _i = 0, _len = data.length) : i = _i = data.length - 1); _ref1 > 0 ? _i < _len : _i >= 0; i = _i += _ref1) {
            v = data[i];
            row += 1 * scale;
            if ((i / 4) % img.width === 0) {
              line += 1 * scale;
              row = 0;
              ggrad = document.createElementNS('http://www.w3.org/2000/svg', 'linearGradient');
              setSVGAttributes(ggrad, {
                id: "gradientLine_" + line,
                spreadMethod: 'pad'
              });
              defs.appendChild(ggrad);
              grect = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
              setSVGAttributes(grect, {
                x: 0,
                y: line,
                width: img.width * scale,
                height: scale,
                fill: "url(#gradientLine_" + line + ")"
              });
              svg.appendChild(grect);
            }
            color = "rgba(" + data[i + 0] + "," + data[i + 1] + "," + data[i + 2] + "," + data[i + 3] + ")";
            gstop = document.createElementNS('http://www.w3.org/2000/svg', 'stop');
            setSVGAttributes(gstop, {
              offset: "" + (row * 100 / img.width) + "%",
              'stop-color': color
            });
            _results.push(ggrad.appendChild(gstop));
          }
          return _results;
        };
        return img.src = src;
      };
      return this;
    };
  }

}).call(this);
