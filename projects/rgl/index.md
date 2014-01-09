Multiple rgl plots on one html page (using knitr & Markdown)
========================================================




askld


```r
# demo(topic='bivar', package='rgl')
x <- sort(rnorm(1000))
y <- rnorm(1000)
z <- rnorm(1000) + atan2(x, y)
plot3d(x, y, z, col = rainbow(1000))
```

<script src="CanvasMatrix.js" type="text/javascript"></script>
<canvas id="bivartextureCanvas" style="display: none;" width="256" height="256">
<img src="bivarsnapshot.png" alt="bivarsnapshot" width=505/><br>
    Your browser does not support the HTML5 canvas element.</canvas>
<!-- ****** points object 6 ****** -->
<script id="bivarvshader6" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	void main(void) {
                vPosition = mvMatrix * vec4(aPos, 1.);
                gl_Position = prMatrix * vPosition;
	  gl_PointSize = 3.;
	  vCol = aCol;
	}
</script>
<script id="bivarfshader6" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 8 ****** -->
<script id="bivarvshader8" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	attribute vec2 aTexcoord;
                varying vec2 vTexcoord;
	attribute vec2 aOfs;
                void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
                pos = pos/pos.w;
                gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="bivarfshader8" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	varying vec2 vTexcoord;
                  uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
                  discard;
                  else
                  gl_FragColor = textureColor;
	}
</script> 
<!-- ****** text object 9 ****** -->
<script id="bivarvshader9" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	attribute vec2 aTexcoord;
                varying vec2 vTexcoord;
	attribute vec2 aOfs;
                void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
                pos = pos/pos.w;
                gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="bivarfshader9" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	varying vec2 vTexcoord;
                  uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
                  discard;
                  else
                  gl_FragColor = textureColor;
	}
</script> 
<!-- ****** text object 10 ****** -->
<script id="bivarvshader10" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	attribute vec2 aTexcoord;
                varying vec2 vTexcoord;
	attribute vec2 aOfs;
                void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
                pos = pos/pos.w;
                gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="bivarfshader10" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	varying vec2 vTexcoord;
                  uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
                  discard;
                  else
                  gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 11 ****** -->
<script id="bivarvshader11" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	void main(void) {
                vPosition = mvMatrix * vec4(aPos, 1.);
                gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="bivarfshader11" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 12 ****** -->
<script id="bivarvshader12" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	attribute vec2 aTexcoord;
                varying vec2 vTexcoord;
	attribute vec2 aOfs;
                void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
                pos = pos/pos.w;
                gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="bivarfshader12" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	varying vec2 vTexcoord;
                  uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
                  discard;
                  else
                  gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 13 ****** -->
<script id="bivarvshader13" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	void main(void) {
                vPosition = mvMatrix * vec4(aPos, 1.);
                gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="bivarfshader13" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 14 ****** -->
<script id="bivarvshader14" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	attribute vec2 aTexcoord;
                varying vec2 vTexcoord;
	attribute vec2 aOfs;
                void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
                pos = pos/pos.w;
                gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="bivarfshader14" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	varying vec2 vTexcoord;
                  uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
                  discard;
                  else
                  gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 15 ****** -->
<script id="bivarvshader15" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	void main(void) {
                vPosition = mvMatrix * vec4(aPos, 1.);
                gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="bivarfshader15" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<!-- ****** text object 16 ****** -->
<script id="bivarvshader16" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	attribute vec2 aTexcoord;
                varying vec2 vTexcoord;
	attribute vec2 aOfs;
                void main(void) {
	  vCol = aCol;
	  vTexcoord = aTexcoord;
	  vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
                pos = pos/pos.w;
                gl_Position = pos + vec4(aOfs, 0.,0.);
	}
</script>
<script id="bivarfshader16" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	varying vec2 vTexcoord;
                  uniform sampler2D uSampler;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
	  if (textureColor.a < 0.1)
                  discard;
                  else
                  gl_FragColor = textureColor;
	}
</script> 
<!-- ****** lines object 17 ****** -->
<script id="bivarvshader17" type="x-shader/x-vertex">
	attribute vec3 aPos;
                attribute vec4 aCol;
                uniform mat4 mvMatrix;
                uniform mat4 prMatrix;
                varying vec4 vCol;
                varying vec4 vPosition;
	void main(void) {
                vPosition = mvMatrix * vec4(aPos, 1.);
                gl_Position = prMatrix * vPosition;
	  vCol = aCol;
	}
</script>
<script id="bivarfshader17" type="x-shader/x-fragment"> 
      #ifdef GL_ES
      precision highp float;
      #endif
      varying vec4 vCol; // carries alpha
      varying vec4 vPosition;
	void main(void) {
      vec4 colDiff = vCol;
	  vec4 lighteffect = colDiff;
	  gl_FragColor = lighteffect;
	}
</script> 
<script type="text/javascript"> 
    var min = Math.min;
    var max = Math.max;
    var sqrt = Math.sqrt;
    var sin = Math.sin;
    var acos = Math.acos;
    var tan = Math.tan;
    var SQRT2 = Math.SQRT2;
    var PI = Math.PI;
    var log = Math.log;
    var exp = Math.exp;
    var bivarWebGLClass = function(){
    this.prefix="bivar";
    this.zoom = 1;
    this.userMatrix = null;
    this.panCallbacks = [];
    this.fovCallbacks = [];
    this.zoomCallbacks = [];
    this.fov = 1;
    };
    (function(){
    this.getShader = function( gl, id ){
    var shaderScript = document.getElementById ( id );
    var str = "";
    var k = shaderScript.firstChild;
    while ( k ){
    if ( k.nodeType == 3 ) str += k.textContent;
    k = k.nextSibling;
    }
    var shader;
    if ( shaderScript.type == "x-shader/x-fragment" )
    shader = gl.createShader ( gl.FRAGMENT_SHADER );
    else if ( shaderScript.type == "x-shader/x-vertex" )
    shader = gl.createShader(gl.VERTEX_SHADER);
    else return null;
    gl.shaderSource(shader, str);
    gl.compileShader(shader);
    if (gl.getShaderParameter(shader, gl.COMPILE_STATUS) == 0)
    alert(gl.getShaderInfoLog(shader));
    return shader;
    };
    this.start = function(){
    var debug = function(msg) {
    document.getElementById("bivardebug").innerHTML = msg;
    }
    debug("");
    var canvas = document.getElementById("bivarcanvas");
    if (!window.WebGLRenderingContext){
    debug("<img src=\"bivarsnapshot.png\" alt=\"bivarsnapshot\" width=505/><br> Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
    return;
    }
    var gl;
    try {
    // Try to grab the standard context. If it fails, fallback to experimental.
    gl = canvas.getContext("webgl") 
    || canvas.getContext("experimental-webgl");
    }
    catch(e) {}
    if ( !gl ) {
    debug("<img src=\"bivarsnapshot.png\" alt=\"bivarsnapshot\" width=505/><br> Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
    return;
    }
    var width = 505;  var height = 505;
    canvas.width = width;   canvas.height = height;
    gl.viewport(0, 0, width, height);
    var prMatrix = new CanvasMatrix4();
    var mvMatrix = new CanvasMatrix4();
    var normMatrix = new CanvasMatrix4();
    var saveMat = new CanvasMatrix4();
    saveMat.makeIdentity();
    var distance;
    var posLoc = 0;
    var colLoc = 1;
	   this.setZoom(1);
      this.setFOV(30);
	   this.userMatrix = new CanvasMatrix4();
    this.setUserMatrix([
	    1, 0, 0, 0,
	    0, 0.3420201, -0.9396926, 0,
	    0, 0.9396926, 0.3420201, 0,
	    0, 0, 0, 1
		]);
	   function getPowerOfTwo(value) {
    var pow = 1;
    while(pow<value) {
    pow *= 2;
    }
    return pow;
    }
    function handleLoadedTexture(texture, textureCanvas) {
    gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
    gl.bindTexture(gl.TEXTURE_2D, texture);
    gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
    gl.generateMipmap(gl.TEXTURE_2D);
    gl.bindTexture(gl.TEXTURE_2D, null);
    }
    function loadImageToTexture(filename, texture) {   
    var canvas = document.getElementById("bivartextureCanvas");
    var ctx = canvas.getContext("2d");
    var image = new Image();
    image.onload = function() {
    var w = image.width;
    var h = image.height;
    var canvasX = getPowerOfTwo(w);
    var canvasY = getPowerOfTwo(h);
    canvas.width = canvasX;
    canvas.height = canvasY;
    ctx.imageSmoothingEnabled = true;
    ctx.drawImage(image, 0, 0, canvasX, canvasY);
    handleLoadedTexture(texture, canvas);
    drawScene.call(this);
    }
    image.src = filename;
    }  	   
	   function drawTextToCanvas(text, cex) {
    var canvasX, canvasY;
    var textX, textY;
    var textHeight = 20 * cex;
    var textColour = "white";
    var fontFamily = "Arial";
    var backgroundColour = "rgba(0,0,0,0)";
    var canvas = document.getElementById("bivartextureCanvas");
    var ctx = canvas.getContext("2d");
    ctx.font = textHeight+"px "+fontFamily;
    canvasX = 1;
    var widths = [];
    for (var i = 0; i < text.length; i++)  {
    widths[i] = ctx.measureText(text[i]).width;
    canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
    }	  
    canvasX = getPowerOfTwo(canvasX);
    var offset = 2*textHeight; // offset to first baseline
    var skip = 2*textHeight;   // skip between baselines	  
    canvasY = getPowerOfTwo(offset + text.length*skip);
    canvas.width = canvasX;
    canvas.height = canvasY;
    ctx.fillStyle = backgroundColour;
    ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    ctx.fillStyle = textColour;
    ctx.textAlign = "left";
    ctx.textBaseline = "alphabetic";
    ctx.font = textHeight+"px "+fontFamily;
    for(var i = 0; i < text.length; i++) {
    textY = i*skip + offset;
    ctx.fillText(text[i], 0,  textY);
    }
    return {canvasX:canvasX, canvasY:canvasY,
    widths:widths, textHeight:textHeight,
    offset:offset, skip:skip};
    }
      // ****** points object 6 ******
	   var prog6  = gl.createProgram();
        gl.attachShader(prog6, this.getShader( gl, "bivarvshader6" ));
        gl.attachShader(prog6, this.getShader( gl, "bivarfshader6" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog6, 0, "aPos");
        gl.bindAttribLocation(prog6, 1, "aCol");
        gl.linkProgram(prog6);
	   var v=new Float32Array([
	    -3.319647, 0.6052057, -1.710457, 1, 0, 0, 1,
	    -3.022225, 0.5578204, -0.9204168, 1, 0.007843138, 0, 1,
	    -2.78563, -1.278291, -1.684287, 1, 0.01176471, 0, 1,
	    -2.611347, -0.3581887, -0.2799613, 1, 0.01960784, 0, 1,
	    -2.575681, -0.8389705, -0.2927468, 1, 0.02352941, 0, 1,
	    -2.53306, 1.181062, -0.9526535, 1, 0.03137255, 0, 1,
	    -2.413422, 1.669047, -2.254604, 1, 0.03529412, 0, 1,
	    -2.412413, -0.1608348, -1.711687, 1, 0.04313726, 0, 1,
	    -2.411239, -0.1258855, -1.128554, 1, 0.04705882, 0, 1,
	    -2.408198, 1.013013, -1.228971, 1, 0.05490196, 0, 1,
	    -2.403807, -0.4298343, -3.29031, 1, 0.05882353, 0, 1,
	    -2.397117, -0.7667465, -0.8544188, 1, 0.06666667, 0, 1,
	    -2.378613, -1.152731, -2.664866, 1, 0.07058824, 0, 1,
	    -2.371164, 0.981407, -2.198817, 1, 0.07843138, 0, 1,
	    -2.366909, 0.5889097, -1.177346, 1, 0.08235294, 0, 1,
	    -2.347619, -0.9968831, -1.467678, 1, 0.09019608, 0, 1,
	    -2.291472, 0.1590437, -1.614775, 1, 0.09411765, 0, 1,
	    -2.283849, -0.7532023, -2.996169, 1, 0.1019608, 0, 1,
	    -2.260525, -0.2261607, -2.492903, 1, 0.1098039, 0, 1,
	    -2.230356, 0.2930277, -1.766161, 1, 0.1137255, 0, 1,
	    -2.210227, -2.014817, -2.505747, 1, 0.1215686, 0, 1,
	    -2.188679, -0.07187827, -0.8868949, 1, 0.1254902, 0, 1,
	    -2.149674, -0.3599485, -1.560344, 1, 0.1333333, 0, 1,
	    -2.137964, 0.1892677, -1.008973, 1, 0.1372549, 0, 1,
	    -2.129714, -1.161354, -1.814186, 1, 0.145098, 0, 1,
	    -2.11151, 0.2373095, -0.1817839, 1, 0.1490196, 0, 1,
	    -2.094622, -0.07527383, -1.321722, 1, 0.1568628, 0, 1,
	    -2.040706, -0.5162842, -0.3645878, 1, 0.1607843, 0, 1,
	    -2.030524, -0.6577085, -1.892444, 1, 0.1686275, 0, 1,
	    -2.02051, 0.7970214, -2.749327, 1, 0.172549, 0, 1,
	    -2.02015, 0.8736503, -0.3427802, 1, 0.1803922, 0, 1,
	    -1.974493, 0.005153894, -2.869806, 1, 0.1843137, 0, 1,
	    -1.956522, -2.609102, -0.984475, 1, 0.1921569, 0, 1,
	    -1.934693, 0.2223319, -1.285968, 1, 0.1960784, 0, 1,
	    -1.9222, 1.068156, 0.3467848, 1, 0.2039216, 0, 1,
	    -1.910091, -1.801543, -3.506976, 1, 0.2117647, 0, 1,
	    -1.886696, 0.5473045, -2.039596, 1, 0.2156863, 0, 1,
	    -1.872454, -0.5304008, -2.850016, 1, 0.2235294, 0, 1,
	    -1.869595, -0.106599, -2.475856, 1, 0.227451, 0, 1,
	    -1.858252, -2.599939, -1.282495, 1, 0.2352941, 0, 1,
	    -1.839071, 0.7701176, -1.32385, 1, 0.2392157, 0, 1,
	    -1.834812, 1.143208, -0.9720437, 1, 0.2470588, 0, 1,
	    -1.833127, -1.253095, -2.513156, 1, 0.2509804, 0, 1,
	    -1.82355, -0.7629458, -2.966178, 1, 0.2588235, 0, 1,
	    -1.82173, -0.9504156, -2.727201, 1, 0.2627451, 0, 1,
	    -1.809985, 0.06472436, -0.7286873, 1, 0.2705882, 0, 1,
	    -1.806453, 0.1319838, -2.991468, 1, 0.2745098, 0, 1,
	    -1.80066, -0.2099091, -3.024535, 1, 0.282353, 0, 1,
	    -1.799761, 1.238386, 0.9227281, 1, 0.2862745, 0, 1,
	    -1.797702, 0.82552, 0.4988237, 1, 0.2941177, 0, 1,
	    -1.792351, -2.687151, -3.667595, 1, 0.3019608, 0, 1,
	    -1.778018, -1.910686, -2.43404, 1, 0.3058824, 0, 1,
	    -1.776946, 0.3633013, 0.9410558, 1, 0.3137255, 0, 1,
	    -1.765345, -0.8328521, -3.395167, 1, 0.3176471, 0, 1,
	    -1.75407, -0.201695, -1.764956, 1, 0.3254902, 0, 1,
	    -1.74883, 0.266804, -1.660264, 1, 0.3294118, 0, 1,
	    -1.714263, -0.2905976, -2.443506, 1, 0.3372549, 0, 1,
	    -1.712921, -0.6399729, -3.248967, 1, 0.3411765, 0, 1,
	    -1.70373, 0.4781883, -3.024704, 1, 0.3490196, 0, 1,
	    -1.698174, -0.0326796, -2.079404, 1, 0.3529412, 0, 1,
	    -1.692805, -0.7018617, -1.973258, 1, 0.3607843, 0, 1,
	    -1.690368, -0.6804274, -1.36182, 1, 0.3647059, 0, 1,
	    -1.673054, -1.152714, -1.133678, 1, 0.372549, 0, 1,
	    -1.661895, 0.7625721, -0.2892021, 1, 0.3764706, 0, 1,
	    -1.661426, -1.067928, -2.737465, 1, 0.3843137, 0, 1,
	    -1.643242, 0.003716162, 0.1816809, 1, 0.3882353, 0, 1,
	    -1.570218, 0.8931678, -1.18432, 1, 0.3960784, 0, 1,
	    -1.569872, -0.962923, -2.218525, 1, 0.4039216, 0, 1,
	    -1.557753, -0.7657271, -0.3437324, 1, 0.4078431, 0, 1,
	    -1.548984, 0.4503798, -1.918887, 1, 0.4156863, 0, 1,
	    -1.547139, -1.328196, -1.639245, 1, 0.4196078, 0, 1,
	    -1.53729, -0.2402425, -1.851019, 1, 0.427451, 0, 1,
	    -1.521112, -1.246017, 0.05326161, 1, 0.4313726, 0, 1,
	    -1.518811, -1.06485, -2.86453, 1, 0.4392157, 0, 1,
	    -1.518674, -1.168058, -1.650756, 1, 0.4431373, 0, 1,
	    -1.516152, 1.775482, 0.6846482, 1, 0.4509804, 0, 1,
	    -1.510849, 0.117224, -3.162358, 1, 0.454902, 0, 1,
	    -1.496794, 0.3990853, -2.453792, 1, 0.4627451, 0, 1,
	    -1.489209, 0.05733874, -1.718266, 1, 0.4666667, 0, 1,
	    -1.464919, -1.013352, -1.757719, 1, 0.4745098, 0, 1,
	    -1.461282, -1.521863, -3.595583, 1, 0.4784314, 0, 1,
	    -1.459368, -0.3790089, -2.538362, 1, 0.4862745, 0, 1,
	    -1.456509, -0.2951822, -1.247462, 1, 0.4901961, 0, 1,
	    -1.449214, -1.998261, -2.851091, 1, 0.4980392, 0, 1,
	    -1.44278, -0.8522412, -3.492063, 1, 0.5058824, 0, 1,
	    -1.442482, -1.142351, -1.55298, 1, 0.509804, 0, 1,
	    -1.43995, -0.01636226, -1.298396, 1, 0.5176471, 0, 1,
	    -1.43261, -0.1039199, -2.160827, 1, 0.5215687, 0, 1,
	    -1.428443, -0.3380564, -1.099272, 1, 0.5294118, 0, 1,
	    -1.424069, 0.8386129, -1.255201, 1, 0.5333334, 0, 1,
	    -1.406049, -1.718034, -1.787811, 1, 0.5411765, 0, 1,
	    -1.404513, -0.04536447, -1.16408, 1, 0.5450981, 0, 1,
	    -1.397595, -0.5755062, -2.574838, 1, 0.5529412, 0, 1,
	    -1.390265, 0.2972772, -1.427028, 1, 0.5568628, 0, 1,
	    -1.36912, -0.183368, -1.590396, 1, 0.5647059, 0, 1,
	    -1.366454, 1.217307, -2.646941, 1, 0.5686275, 0, 1,
	    -1.359542, 0.0609795, -0.1278615, 1, 0.5764706, 0, 1,
	    -1.346264, 1.021491, -2.223949, 1, 0.5803922, 0, 1,
	    -1.341661, 0.6549866, -0.25089, 1, 0.5882353, 0, 1,
	    -1.338568, -0.5544252, -3.054887, 1, 0.5921569, 0, 1,
	    -1.336849, 0.3620592, -1.846215, 1, 0.6, 0, 1,
	    -1.332786, -0.6450207, -2.601747, 1, 0.6078432, 0, 1,
	    -1.332657, 1.102014, -1.583337, 1, 0.6117647, 0, 1,
	    -1.328465, -0.411765, -2.811011, 1, 0.6196079, 0, 1,
	    -1.312664, -1.040149, -2.962532, 1, 0.6235294, 0, 1,
	    -1.309212, 1.595092, -2.01999, 1, 0.6313726, 0, 1,
	    -1.30872, -1.025203, -1.513457, 1, 0.6352941, 0, 1,
	    -1.307768, 0.6173943, -0.9173451, 1, 0.6431373, 0, 1,
	    -1.306353, -0.5463943, -3.32492, 1, 0.6470588, 0, 1,
	    -1.305705, 0.3474788, -1.100666, 1, 0.654902, 0, 1,
	    -1.284154, -0.3795526, -4.049817, 1, 0.6588235, 0, 1,
	    -1.282722, 0.1866577, 0.6498352, 1, 0.6666667, 0, 1,
	    -1.281121, -0.6844082, -1.723539, 1, 0.6705883, 0, 1,
	    -1.277011, 1.729412, 0.5751711, 1, 0.6784314, 0, 1,
	    -1.270054, 0.2159049, -0.4666878, 1, 0.682353, 0, 1,
	    -1.268817, 0.4569552, -1.787151, 1, 0.6901961, 0, 1,
	    -1.265307, 0.1455093, 0.03001822, 1, 0.6941177, 0, 1,
	    -1.264944, -2.034867, -2.851357, 1, 0.7019608, 0, 1,
	    -1.262567, -0.01831664, -3.382532, 1, 0.7098039, 0, 1,
	    -1.259724, -0.2519778, -0.7071475, 1, 0.7137255, 0, 1,
	    -1.254207, -0.02084782, -2.262866, 1, 0.7215686, 0, 1,
	    -1.251134, 0.1495676, 0.1406905, 1, 0.7254902, 0, 1,
	    -1.24363, -0.4274073, -2.219939, 1, 0.7333333, 0, 1,
	    -1.237821, -0.926197, -1.4428, 1, 0.7372549, 0, 1,
	    -1.220087, 1.361407, -1.061642, 1, 0.7450981, 0, 1,
	    -1.215045, 0.9561733, -1.846994, 1, 0.7490196, 0, 1,
	    -1.21367, -0.3667448, -0.7386179, 1, 0.7568628, 0, 1,
	    -1.20731, 1.392183, -1.314973, 1, 0.7607843, 0, 1,
	    -1.197539, 0.5547173, 0.2302319, 1, 0.7686275, 0, 1,
	    -1.191868, -0.3725785, -0.7340963, 1, 0.772549, 0, 1,
	    -1.1913, -0.9163837, -2.559387, 1, 0.7803922, 0, 1,
	    -1.186868, -1.490182, -2.89482, 1, 0.7843137, 0, 1,
	    -1.178851, 0.8941957, -1.205582, 1, 0.7921569, 0, 1,
	    -1.167424, 0.6915197, -2.194496, 1, 0.7960784, 0, 1,
	    -1.165984, -1.890226, -3.320574, 1, 0.8039216, 0, 1,
	    -1.164284, 0.752561, -1.356441, 1, 0.8117647, 0, 1,
	    -1.162222, -1.297246, -2.074875, 1, 0.8156863, 0, 1,
	    -1.149612, -0.6066041, -0.09596948, 1, 0.8235294, 0, 1,
	    -1.147195, -0.1720448, -2.15698, 1, 0.827451, 0, 1,
	    -1.137391, 0.07684255, -0.6869158, 1, 0.8352941, 0, 1,
	    -1.131305, -0.4874407, -2.635388, 1, 0.8392157, 0, 1,
	    -1.131041, -0.1247756, -1.73724, 1, 0.8470588, 0, 1,
	    -1.130623, -1.542624, -3.433982, 1, 0.8509804, 0, 1,
	    -1.118489, -1.472781, -2.418288, 1, 0.8588235, 0, 1,
	    -1.107045, -0.8334936, -1.624389, 1, 0.8627451, 0, 1,
	    -1.105122, 0.2799165, 0.4018639, 1, 0.8705882, 0, 1,
	    -1.10341, -0.7797939, -5.191226, 1, 0.8745098, 0, 1,
	    -1.102275, 0.86862, -0.01896096, 1, 0.8823529, 0, 1,
	    -1.095294, -1.071772, -2.330686, 1, 0.8862745, 0, 1,
	    -1.094735, 0.4751919, -1.86619, 1, 0.8941177, 0, 1,
	    -1.092515, 0.7509835, -1.539903, 1, 0.8980392, 0, 1,
	    -1.092341, 1.523257, -0.5741599, 1, 0.9058824, 0, 1,
	    -1.091585, 0.6962802, 0.4219724, 1, 0.9137255, 0, 1,
	    -1.084467, 0.4419646, -3.076118, 1, 0.9176471, 0, 1,
	    -1.082805, -0.242007, -1.664996, 1, 0.9254902, 0, 1,
	    -1.06838, -1.11409, -2.413553, 1, 0.9294118, 0, 1,
	    -1.063799, 0.7158137, -0.2903428, 1, 0.9372549, 0, 1,
	    -1.057864, -0.8138742, -3.049068, 1, 0.9411765, 0, 1,
	    -1.057775, 0.6335043, 0.3126864, 1, 0.9490196, 0, 1,
	    -1.05553, 0.5132212, -0.30489, 1, 0.9529412, 0, 1,
	    -1.050516, 0.7046289, -2.436774, 1, 0.9607843, 0, 1,
	    -1.047354, -0.1722415, -2.292609, 1, 0.9647059, 0, 1,
	    -1.035903, 0.2845553, -1.4974, 1, 0.972549, 0, 1,
	    -1.032606, -2.214935, -2.043739, 1, 0.9764706, 0, 1,
	    -1.029042, -0.8553072, -2.969433, 1, 0.9843137, 0, 1,
	    -1.02893, 1.124896, -0.6447639, 1, 0.9882353, 0, 1,
	    -1.021364, 0.8562739, -1.913147, 1, 0.9960784, 0, 1,
	    -1.01531, -0.3193569, -1.258337, 0.9960784, 1, 0, 1,
	    -1.013079, 0.5197076, -2.691201, 0.9921569, 1, 0, 1,
	    -1.010309, -2.073148, -0.9767464, 0.9843137, 1, 0, 1,
	    -1.001853, -0.7747527, -1.265617, 0.9803922, 1, 0, 1,
	    -0.9958288, 1.083087, -0.4753935, 0.972549, 1, 0, 1,
	    -0.9834021, -0.2779301, -2.053444, 0.9686275, 1, 0, 1,
	    -0.982802, 1.077272, -0.2785503, 0.9607843, 1, 0, 1,
	    -0.9812618, -0.02066754, -2.205617, 0.9568627, 1, 0, 1,
	    -0.9720932, -0.07755447, -3.23952, 0.9490196, 1, 0, 1,
	    -0.9703681, -1.207152, -4.639097, 0.945098, 1, 0, 1,
	    -0.9659145, -0.7957096, -3.176844, 0.9372549, 1, 0, 1,
	    -0.9631487, 0.4866038, 0.05579929, 0.9333333, 1, 0, 1,
	    -0.9562078, 0.1491036, -1.047026, 0.9254902, 1, 0, 1,
	    -0.9498875, -2.119361, -3.188016, 0.9215686, 1, 0, 1,
	    -0.9357756, 0.5617974, -1.545975, 0.9137255, 1, 0, 1,
	    -0.9272229, 0.4251073, -1.264878, 0.9098039, 1, 0, 1,
	    -0.9204885, 0.4791015, 1.363607, 0.9019608, 1, 0, 1,
	    -0.9182229, 0.1439525, -1.669016, 0.8941177, 1, 0, 1,
	    -0.9137822, 0.6465081, -0.9822733, 0.8901961, 1, 0, 1,
	    -0.9085453, -1.025094, -1.706642, 0.8823529, 1, 0, 1,
	    -0.9045868, 1.301294, 0.116821, 0.8784314, 1, 0, 1,
	    -0.9044426, -0.6591248, -2.049872, 0.8705882, 1, 0, 1,
	    -0.8978691, -0.1067125, -0.3311772, 0.8666667, 1, 0, 1,
	    -0.8908414, 0.9894885, -0.8604596, 0.8588235, 1, 0, 1,
	    -0.8908053, 0.7625779, -1.228051, 0.854902, 1, 0, 1,
	    -0.8877133, 1.395897, -0.07905284, 0.8470588, 1, 0, 1,
	    -0.8792806, 1.996894, -0.5147993, 0.8431373, 1, 0, 1,
	    -0.8786381, -0.9534302, -1.706908, 0.8352941, 1, 0, 1,
	    -0.8763381, -1.119798, -1.198136, 0.8313726, 1, 0, 1,
	    -0.8673148, -0.06901003, -0.4030885, 0.8235294, 1, 0, 1,
	    -0.8653511, -0.1949023, -2.23483, 0.8196079, 1, 0, 1,
	    -0.8644228, -0.4974071, -1.835337, 0.8117647, 1, 0, 1,
	    -0.854781, -0.222848, -2.609743, 0.8078431, 1, 0, 1,
	    -0.8544745, 0.1749756, -2.149401, 0.8, 1, 0, 1,
	    -0.8538553, 1.065242, -0.6490464, 0.7921569, 1, 0, 1,
	    -0.8502811, 0.5413752, -1.092571, 0.7882353, 1, 0, 1,
	    -0.8376688, 0.4980158, -0.6789296, 0.7803922, 1, 0, 1,
	    -0.8292706, -0.4371915, -3.487079, 0.7764706, 1, 0, 1,
	    -0.8225485, 0.1040788, 0.3234708, 0.7686275, 1, 0, 1,
	    -0.8209711, -1.076666, -3.281242, 0.7647059, 1, 0, 1,
	    -0.8160275, -0.7049084, -3.439881, 0.7568628, 1, 0, 1,
	    -0.815307, -1.805179, -2.279654, 0.7529412, 1, 0, 1,
	    -0.8146726, -0.0580835, -3.604781, 0.7450981, 1, 0, 1,
	    -0.8121605, 0.2594646, -0.7346097, 0.7411765, 1, 0, 1,
	    -0.8000312, -1.748767, -4.025394, 0.7333333, 1, 0, 1,
	    -0.7996285, -2.268478, -2.854125, 0.7294118, 1, 0, 1,
	    -0.7993756, 1.506199, -0.1779625, 0.7215686, 1, 0, 1,
	    -0.7921122, 0.3429921, -1.185212, 0.7176471, 1, 0, 1,
	    -0.778264, -0.8768337, -1.825948, 0.7098039, 1, 0, 1,
	    -0.7742267, 1.766365, -0.6446319, 0.7058824, 1, 0, 1,
	    -0.7696941, -0.5307501, -2.164769, 0.6980392, 1, 0, 1,
	    -0.7607752, 1.740114, -1.201129, 0.6901961, 1, 0, 1,
	    -0.7602037, 1.910669, -0.4156574, 0.6862745, 1, 0, 1,
	    -0.7573645, -0.5041376, -0.8212243, 0.6784314, 1, 0, 1,
	    -0.7569957, -1.886449, -1.662243, 0.6745098, 1, 0, 1,
	    -0.7569394, -0.01429789, -1.765655, 0.6666667, 1, 0, 1,
	    -0.7558249, -0.2474062, -1.399488, 0.6627451, 1, 0, 1,
	    -0.7536524, -1.574033, -3.514566, 0.654902, 1, 0, 1,
	    -0.7526294, 0.2706841, -1.704083, 0.6509804, 1, 0, 1,
	    -0.7502828, -0.04174074, -2.021341, 0.6431373, 1, 0, 1,
	    -0.7441456, 1.16138, -1.138432, 0.6392157, 1, 0, 1,
	    -0.7403895, 0.4999828, -1.379968, 0.6313726, 1, 0, 1,
	    -0.7403524, 0.1292961, -0.717252, 0.627451, 1, 0, 1,
	    -0.736391, 0.999355, -0.1630883, 0.6196079, 1, 0, 1,
	    -0.7357139, 0.8425151, -0.9263323, 0.6156863, 1, 0, 1,
	    -0.7354398, 1.672165, -0.2639093, 0.6078432, 1, 0, 1,
	    -0.7350128, 0.7740593, -1.470086, 0.6039216, 1, 0, 1,
	    -0.7324222, -0.2228357, -1.868392, 0.5960785, 1, 0, 1,
	    -0.7266278, -0.116135, -2.114509, 0.5882353, 1, 0, 1,
	    -0.725992, -0.3225508, -1.440729, 0.5843138, 1, 0, 1,
	    -0.7255553, -1.2222, -1.988478, 0.5764706, 1, 0, 1,
	    -0.7231972, -0.5982995, -1.945559, 0.572549, 1, 0, 1,
	    -0.7175068, 1.233803, -0.8841431, 0.5647059, 1, 0, 1,
	    -0.7159539, 1.669039, 0.3003173, 0.5607843, 1, 0, 1,
	    -0.7138459, -0.4390534, -2.501086, 0.5529412, 1, 0, 1,
	    -0.7121588, -0.6855932, -2.739816, 0.5490196, 1, 0, 1,
	    -0.7047798, 1.589307, -0.3205575, 0.5411765, 1, 0, 1,
	    -0.7042553, -1.784961, -2.995646, 0.5372549, 1, 0, 1,
	    -0.6990291, 3.713125, -0.5423316, 0.5294118, 1, 0, 1,
	    -0.6988127, -0.5168293, -2.320237, 0.5254902, 1, 0, 1,
	    -0.6933898, 0.5315198, 0.1035334, 0.5176471, 1, 0, 1,
	    -0.6913542, -1.854058, -3.918387, 0.5137255, 1, 0, 1,
	    -0.6886665, 0.3895537, -0.4894971, 0.5058824, 1, 0, 1,
	    -0.6820821, 1.064174, -0.5144367, 0.5019608, 1, 0, 1,
	    -0.6710029, 0.7322503, 0.8491619, 0.4941176, 1, 0, 1,
	    -0.6700975, 1.606003, -0.1669408, 0.4862745, 1, 0, 1,
	    -0.6688845, -0.1742288, -1.241284, 0.4823529, 1, 0, 1,
	    -0.6676787, 0.816891, 0.6192213, 0.4745098, 1, 0, 1,
	    -0.6659004, -1.792273, -3.894353, 0.4705882, 1, 0, 1,
	    -0.665471, 0.1202837, -3.583013, 0.4627451, 1, 0, 1,
	    -0.664412, -0.7446069, -0.4242763, 0.4588235, 1, 0, 1,
	    -0.6619597, 1.060757, -0.03895143, 0.4509804, 1, 0, 1,
	    -0.6587073, 0.5136546, -0.59785, 0.4470588, 1, 0, 1,
	    -0.6582574, -1.569929, -2.486262, 0.4392157, 1, 0, 1,
	    -0.6568433, 0.1211943, 1.341833, 0.4352941, 1, 0, 1,
	    -0.6553369, -2.991511, -2.631174, 0.427451, 1, 0, 1,
	    -0.6540496, 0.9194884, 1.155062, 0.4235294, 1, 0, 1,
	    -0.6504718, 0.08617585, -1.586417, 0.4156863, 1, 0, 1,
	    -0.6476428, -0.6245747, -3.548105, 0.4117647, 1, 0, 1,
	    -0.6460281, 0.1705436, -1.877265, 0.4039216, 1, 0, 1,
	    -0.6437085, 1.078025, -0.7567998, 0.3960784, 1, 0, 1,
	    -0.6406265, 0.4812347, 1.57149, 0.3921569, 1, 0, 1,
	    -0.6351124, -0.138549, -2.050224, 0.3843137, 1, 0, 1,
	    -0.6346585, 0.9831393, -0.6004701, 0.3803922, 1, 0, 1,
	    -0.6332792, 0.8364527, -2.395732, 0.372549, 1, 0, 1,
	    -0.6313293, -0.6352401, -2.388454, 0.3686275, 1, 0, 1,
	    -0.6304324, 0.07466462, -2.145215, 0.3607843, 1, 0, 1,
	    -0.6243507, -0.4939924, -4.226619, 0.3568628, 1, 0, 1,
	    -0.6191173, -0.08939252, -1.386575, 0.3490196, 1, 0, 1,
	    -0.6138602, 0.6828871, -1.969585, 0.345098, 1, 0, 1,
	    -0.6100153, 0.7672981, -0.2594141, 0.3372549, 1, 0, 1,
	    -0.6091554, -0.1021912, -3.5078, 0.3333333, 1, 0, 1,
	    -0.6055935, -0.9211689, -2.567487, 0.3254902, 1, 0, 1,
	    -0.602625, -0.9193331, -3.049536, 0.3215686, 1, 0, 1,
	    -0.595486, -0.002183927, -0.456893, 0.3137255, 1, 0, 1,
	    -0.5949863, -1.419979, -3.338698, 0.3098039, 1, 0, 1,
	    -0.5886965, 0.8613196, 0.2373184, 0.3019608, 1, 0, 1,
	    -0.5874051, -0.8313458, -1.303643, 0.2941177, 1, 0, 1,
	    -0.5830432, 0.9220546, -0.148521, 0.2901961, 1, 0, 1,
	    -0.5830311, -1.239437, -0.8489, 0.282353, 1, 0, 1,
	    -0.5804113, -0.6147931, -2.922188, 0.2784314, 1, 0, 1,
	    -0.568904, -0.590122, -0.9080135, 0.2705882, 1, 0, 1,
	    -0.5661711, 0.3303685, -1.5, 0.2666667, 1, 0, 1,
	    -0.5634905, -0.661862, -1.870581, 0.2588235, 1, 0, 1,
	    -0.563467, 1.780728, 0.6901112, 0.254902, 1, 0, 1,
	    -0.5598044, -0.8846455, -0.8412923, 0.2470588, 1, 0, 1,
	    -0.5595497, -0.4348758, -2.955482, 0.2431373, 1, 0, 1,
	    -0.5585179, 1.238339, -0.4773766, 0.2352941, 1, 0, 1,
	    -0.5542313, -0.003097788, -0.624283, 0.2313726, 1, 0, 1,
	    -0.5498084, -0.3305082, -0.5857973, 0.2235294, 1, 0, 1,
	    -0.5447939, -0.6062531, -2.720946, 0.2196078, 1, 0, 1,
	    -0.5420363, 0.7939897, -0.03784882, 0.2117647, 1, 0, 1,
	    -0.5383381, 0.2506018, -2.057867, 0.2078431, 1, 0, 1,
	    -0.5342122, -0.4951967, -2.833418, 0.2, 1, 0, 1,
	    -0.5327709, -1.396808, -1.284246, 0.1921569, 1, 0, 1,
	    -0.5306283, 0.182702, -1.329921, 0.1882353, 1, 0, 1,
	    -0.5278927, -0.6513794, -2.384793, 0.1803922, 1, 0, 1,
	    -0.5169743, 0.5523564, 0.1264955, 0.1764706, 1, 0, 1,
	    -0.5105398, -1.032546, -2.621604, 0.1686275, 1, 0, 1,
	    -0.5102931, 0.742771, 0.4171461, 0.1647059, 1, 0, 1,
	    -0.5099041, -1.750375, -2.232781, 0.1568628, 1, 0, 1,
	    -0.508166, -0.5760109, -0.3733588, 0.1529412, 1, 0, 1,
	    -0.5054963, -0.5866925, -1.570526, 0.145098, 1, 0, 1,
	    -0.5046059, 0.5332262, -0.9183336, 0.1411765, 1, 0, 1,
	    -0.495568, 1.511066, -0.3202163, 0.1333333, 1, 0, 1,
	    -0.48975, -0.5624011, -3.410154, 0.1294118, 1, 0, 1,
	    -0.4897189, -0.5723371, -2.829739, 0.1215686, 1, 0, 1,
	    -0.4891101, 2.582516, 1.425727, 0.1176471, 1, 0, 1,
	    -0.4879228, -0.6519918, -1.560191, 0.1098039, 1, 0, 1,
	    -0.4861194, 1.067804, 0.3400828, 0.1058824, 1, 0, 1,
	    -0.483439, 1.158533, -0.9505394, 0.09803922, 1, 0, 1,
	    -0.4816056, 0.5002325, -0.8616242, 0.09019608, 1, 0, 1,
	    -0.4768693, 0.3121228, -1.149114, 0.08627451, 1, 0, 1,
	    -0.4757875, -1.070888, -4.219484, 0.07843138, 1, 0, 1,
	    -0.4695361, 0.9932597, 1.827527, 0.07450981, 1, 0, 1,
	    -0.4683143, 0.3329344, -1.707492, 0.06666667, 1, 0, 1,
	    -0.4662162, -0.0638229, -1.937256, 0.0627451, 1, 0, 1,
	    -0.4617123, -0.1422071, -2.336512, 0.05490196, 1, 0, 1,
	    -0.4597414, -0.04562379, -1.506052, 0.05098039, 1, 0, 1,
	    -0.458491, -0.589579, -1.424451, 0.04313726, 1, 0, 1,
	    -0.4539069, -1.877793, -3.114126, 0.03921569, 1, 0, 1,
	    -0.4537523, 1.109617, -1.30991, 0.03137255, 1, 0, 1,
	    -0.4499676, -0.8835838, -3.634921, 0.02745098, 1, 0, 1,
	    -0.4492197, 1.486879, 1.885485, 0.01960784, 1, 0, 1,
	    -0.4485941, -0.9431942, -2.602322, 0.01568628, 1, 0, 1,
	    -0.4439051, 1.080055, -0.7999399, 0.007843138, 1, 0, 1,
	    -0.4421083, -0.04756222, -1.792248, 0.003921569, 1, 0, 1,
	    -0.4399073, -0.2296839, -1.773516, 0, 1, 0.003921569, 1,
	    -0.4398209, 0.3894307, -0.5157103, 0, 1, 0.01176471, 1,
	    -0.4390779, -1.489224, -3.954825, 0, 1, 0.01568628, 1,
	    -0.4386501, -1.15319, -2.051445, 0, 1, 0.02352941, 1,
	    -0.4377634, 0.9745944, -0.9950992, 0, 1, 0.02745098, 1,
	    -0.428314, -0.1899534, -2.652111, 0, 1, 0.03529412, 1,
	    -0.4275872, 0.3249392, -1.698975, 0, 1, 0.03921569, 1,
	    -0.4249346, -0.2104668, -3.306455, 0, 1, 0.04705882, 1,
	    -0.4238932, 1.447192, 1.161689, 0, 1, 0.05098039, 1,
	    -0.4220855, 0.8967329, -0.6637992, 0, 1, 0.05882353, 1,
	    -0.4195708, 1.083145, 0.5413595, 0, 1, 0.0627451, 1,
	    -0.4115113, -1.531606, -4.350465, 0, 1, 0.07058824, 1,
	    -0.4110675, -0.9346656, -3.156229, 0, 1, 0.07450981, 1,
	    -0.4091754, 2.829827, 1.497452, 0, 1, 0.08235294, 1,
	    -0.4088528, -0.310651, -2.354488, 0, 1, 0.08627451, 1,
	    -0.4083344, -2.059991, -1.235205, 0, 1, 0.09411765, 1,
	    -0.4055692, 2.447053, 0.1903794, 0, 1, 0.1019608, 1,
	    -0.4042065, -0.4063264, -1.622826, 0, 1, 0.1058824, 1,
	    -0.4029194, -0.2823374, -0.4031229, 0, 1, 0.1137255, 1,
	    -0.4019731, 0.2774525, -1.517247, 0, 1, 0.1176471, 1,
	    -0.3992534, -0.6738649, -1.889523, 0, 1, 0.1254902, 1,
	    -0.3899808, -0.4834279, -1.796406, 0, 1, 0.1294118, 1,
	    -0.3898381, 0.8851771, 0.9464129, 0, 1, 0.1372549, 1,
	    -0.3879866, -1.329982, -2.570708, 0, 1, 0.1411765, 1,
	    -0.3866853, 0.8967159, 3.483317e-05, 0, 1, 0.1490196, 1,
	    -0.3838115, -0.2314281, -3.124618, 0, 1, 0.1529412, 1,
	    -0.383309, -1.704374, -3.92935, 0, 1, 0.1607843, 1,
	    -0.3808938, 2.123984, -2.2741, 0, 1, 0.1647059, 1,
	    -0.3767141, 0.2241157, 0.2567066, 0, 1, 0.172549, 1,
	    -0.3694662, -1.324727, -3.358478, 0, 1, 0.1764706, 1,
	    -0.3677524, 0.1929234, 0.5722159, 0, 1, 0.1843137, 1,
	    -0.3655545, 0.5929407, -1.002495, 0, 1, 0.1882353, 1,
	    -0.3652414, -1.109056, -2.895807, 0, 1, 0.1960784, 1,
	    -0.3647409, 0.3312156, -1.168896, 0, 1, 0.2039216, 1,
	    -0.3632152, 1.791424, 1.734488, 0, 1, 0.2078431, 1,
	    -0.3618182, -0.8736886, -1.222266, 0, 1, 0.2156863, 1,
	    -0.3610785, -0.1215588, -1.111706, 0, 1, 0.2196078, 1,
	    -0.3592217, 0.2507122, -0.5508761, 0, 1, 0.227451, 1,
	    -0.3518621, -0.7077845, -2.558514, 0, 1, 0.2313726, 1,
	    -0.3502488, -0.9797502, -1.840642, 0, 1, 0.2392157, 1,
	    -0.3477179, -1.646593, -2.115355, 0, 1, 0.2431373, 1,
	    -0.3425318, 0.5421341, 0.4294536, 0, 1, 0.2509804, 1,
	    -0.3422923, 0.03707313, -1.803816, 0, 1, 0.254902, 1,
	    -0.3414826, -1.634581, -2.854366, 0, 1, 0.2627451, 1,
	    -0.3370898, -0.5910847, -0.9358312, 0, 1, 0.2666667, 1,
	    -0.3254241, 0.6492787, 0.2751038, 0, 1, 0.2745098, 1,
	    -0.3241952, 0.3855598, -0.6116542, 0, 1, 0.2784314, 1,
	    -0.3212336, 0.4523879, -0.8790604, 0, 1, 0.2862745, 1,
	    -0.3208273, 1.067967, -0.9677247, 0, 1, 0.2901961, 1,
	    -0.3206972, -0.03284447, -1.264757, 0, 1, 0.2980392, 1,
	    -0.3192361, -2.101794, -2.276318, 0, 1, 0.3058824, 1,
	    -0.3161332, 1.383269, -0.4864016, 0, 1, 0.3098039, 1,
	    -0.3159332, -1.595524, -3.4205, 0, 1, 0.3176471, 1,
	    -0.3157989, -0.741989, -2.126702, 0, 1, 0.3215686, 1,
	    -0.3149807, 1.476764, 0.4787852, 0, 1, 0.3294118, 1,
	    -0.3139926, 0.4783442, -0.3495596, 0, 1, 0.3333333, 1,
	    -0.3111108, -0.9672452, -3.661265, 0, 1, 0.3411765, 1,
	    -0.3094708, 0.5909697, -0.9382195, 0, 1, 0.345098, 1,
	    -0.3076827, 0.5733805, -1.127659, 0, 1, 0.3529412, 1,
	    -0.3064095, -1.428785, -3.312973, 0, 1, 0.3568628, 1,
	    -0.3062148, -0.1903652, -1.115852, 0, 1, 0.3647059, 1,
	    -0.3047306, 0.160428, -2.613677, 0, 1, 0.3686275, 1,
	    -0.3002696, -0.6845306, -2.535629, 0, 1, 0.3764706, 1,
	    -0.2980048, -1.582342, -1.703483, 0, 1, 0.3803922, 1,
	    -0.2963037, -1.172565, -4.888531, 0, 1, 0.3882353, 1,
	    -0.2956666, 1.023884, 1.12335, 0, 1, 0.3921569, 1,
	    -0.2931155, 1.503319, 0.1053174, 0, 1, 0.4, 1,
	    -0.2847289, -1.168722, -1.967739, 0, 1, 0.4078431, 1,
	    -0.2802715, 0.3179319, -1.803268, 0, 1, 0.4117647, 1,
	    -0.2768077, 0.165447, -1.1291, 0, 1, 0.4196078, 1,
	    -0.2759985, 0.3117399, -1.989433, 0, 1, 0.4235294, 1,
	    -0.2756439, -0.004033907, -1.017104, 0, 1, 0.4313726, 1,
	    -0.2751688, -0.4751633, -2.261778, 0, 1, 0.4352941, 1,
	    -0.2721835, -0.8354095, -3.138214, 0, 1, 0.4431373, 1,
	    -0.2684905, 2.99679, -0.03803607, 0, 1, 0.4470588, 1,
	    -0.2665174, 1.123551, -1.41487, 0, 1, 0.454902, 1,
	    -0.2661722, 0.1986187, -0.7726215, 0, 1, 0.4588235, 1,
	    -0.2659212, -1.627782, -4.63384, 0, 1, 0.4666667, 1,
	    -0.2639295, -1.019461, -3.538637, 0, 1, 0.4705882, 1,
	    -0.2630592, 0.05215888, -3.093843, 0, 1, 0.4784314, 1,
	    -0.2621147, -0.2145846, -2.620125, 0, 1, 0.4823529, 1,
	    -0.2542224, -0.8467543, -0.6702092, 0, 1, 0.4901961, 1,
	    -0.2540682, 0.8016691, -1.915457, 0, 1, 0.4941176, 1,
	    -0.2526839, 0.6483998, 0.8266545, 0, 1, 0.5019608, 1,
	    -0.2434046, -1.379614, -3.724301, 0, 1, 0.509804, 1,
	    -0.2414043, 1.943431, -0.07359734, 0, 1, 0.5137255, 1,
	    -0.236088, -0.4162139, -1.612478, 0, 1, 0.5215687, 1,
	    -0.2349435, -0.7501855, -2.477954, 0, 1, 0.5254902, 1,
	    -0.2346418, 2.267614, 0.9110289, 0, 1, 0.5333334, 1,
	    -0.2343522, -0.8115652, -2.00522, 0, 1, 0.5372549, 1,
	    -0.233671, 0.08035841, -1.911686, 0, 1, 0.5450981, 1,
	    -0.2281889, -0.7055762, -3.28784, 0, 1, 0.5490196, 1,
	    -0.2262189, 0.04885124, -0.9722542, 0, 1, 0.5568628, 1,
	    -0.2259754, -1.093457, -1.874277, 0, 1, 0.5607843, 1,
	    -0.2253715, 1.069918, 0.4402323, 0, 1, 0.5686275, 1,
	    -0.2235093, -0.6389918, -1.478682, 0, 1, 0.572549, 1,
	    -0.2170282, 1.284939, 0.8851621, 0, 1, 0.5803922, 1,
	    -0.2164111, -0.5084074, -2.792672, 0, 1, 0.5843138, 1,
	    -0.2124403, -0.1833557, -0.8930337, 0, 1, 0.5921569, 1,
	    -0.2092396, -1.803506, -3.465481, 0, 1, 0.5960785, 1,
	    -0.2051013, 0.002373763, 1.181595, 0, 1, 0.6039216, 1,
	    -0.2046855, -0.9848277, -4.017744, 0, 1, 0.6117647, 1,
	    -0.2041364, -0.01969724, -0.08394555, 0, 1, 0.6156863, 1,
	    -0.2008217, 0.4916521, -1.527974, 0, 1, 0.6235294, 1,
	    -0.1985981, 1.233361, -0.6173472, 0, 1, 0.627451, 1,
	    -0.187776, 1.565073, 0.3076967, 0, 1, 0.6352941, 1,
	    -0.1849443, -0.4896171, -5.362856, 0, 1, 0.6392157, 1,
	    -0.1845719, 1.190692, 0.6612199, 0, 1, 0.6470588, 1,
	    -0.1784626, 1.025358, -0.8034711, 0, 1, 0.6509804, 1,
	    -0.1721759, -1.400651, -3.241837, 0, 1, 0.6588235, 1,
	    -0.1704089, -1.33101, -1.965798, 0, 1, 0.6627451, 1,
	    -0.1700517, 0.8400462, -1.31348, 0, 1, 0.6705883, 1,
	    -0.1671468, 0.6052724, -0.07461175, 0, 1, 0.6745098, 1,
	    -0.1641149, 0.2460693, 0.9156095, 0, 1, 0.682353, 1,
	    -0.1585586, 0.1799946, -1.180329, 0, 1, 0.6862745, 1,
	    -0.1573663, 0.01094858, -1.743388, 0, 1, 0.6941177, 1,
	    -0.150808, 0.8205536, -0.8977433, 0, 1, 0.7019608, 1,
	    -0.1501156, -0.01041626, -1.281202, 0, 1, 0.7058824, 1,
	    -0.1459101, 0.8134183, -1.095106, 0, 1, 0.7137255, 1,
	    -0.1442447, 0.4113976, -0.5096669, 0, 1, 0.7176471, 1,
	    -0.1285568, 0.2573268, -0.04013975, 0, 1, 0.7254902, 1,
	    -0.1131894, 1.735003, -1.964908, 0, 1, 0.7294118, 1,
	    -0.1115438, -0.2172301, -0.9322026, 0, 1, 0.7372549, 1,
	    -0.1069836, -0.8856475, -2.813511, 0, 1, 0.7411765, 1,
	    -0.1063221, -1.937919, -4.062405, 0, 1, 0.7490196, 1,
	    -0.1015834, -1.84119, -1.72304, 0, 1, 0.7529412, 1,
	    -0.1008468, 0.7023754, 0.1877964, 0, 1, 0.7607843, 1,
	    -0.1000487, 0.637567, 0.6956471, 0, 1, 0.7647059, 1,
	    -0.09799106, 0.3284709, -0.4742905, 0, 1, 0.772549, 1,
	    -0.09548172, 0.1911508, -1.23574, 0, 1, 0.7764706, 1,
	    -0.09373531, 0.0352354, -2.563116, 0, 1, 0.7843137, 1,
	    -0.09210046, -0.6462756, -3.768836, 0, 1, 0.7882353, 1,
	    -0.09066591, 0.6574787, -0.901848, 0, 1, 0.7960784, 1,
	    -0.08448055, -0.3183963, -2.335385, 0, 1, 0.8039216, 1,
	    -0.0843858, -0.594788, -2.580311, 0, 1, 0.8078431, 1,
	    -0.0829382, 1.107945, -0.3565494, 0, 1, 0.8156863, 1,
	    -0.08280321, -2.296815, -2.370173, 0, 1, 0.8196079, 1,
	    -0.08262911, -1.58957, -2.112416, 0, 1, 0.827451, 1,
	    -0.08090331, 1.432606, 0.08999392, 0, 1, 0.8313726, 1,
	    -0.073359, 0.03863946, -0.004117877, 0, 1, 0.8392157, 1,
	    -0.06941912, 1.878705, 1.484145, 0, 1, 0.8431373, 1,
	    -0.06842586, -0.6038482, -2.499351, 0, 1, 0.8509804, 1,
	    -0.0668869, -0.06744449, -1.636868, 0, 1, 0.854902, 1,
	    -0.06541492, -0.0417542, -3.327114, 0, 1, 0.8627451, 1,
	    -0.06162226, -0.7370272, -1.613727, 0, 1, 0.8666667, 1,
	    -0.06101703, -0.8705545, -2.953219, 0, 1, 0.8745098, 1,
	    -0.05970835, 1.390599, -1.304182, 0, 1, 0.8784314, 1,
	    -0.05881312, -0.3269417, -2.24001, 0, 1, 0.8862745, 1,
	    -0.05654924, 0.3152201, -0.463177, 0, 1, 0.8901961, 1,
	    -0.0543196, 0.9731422, -1.270691, 0, 1, 0.8980392, 1,
	    -0.04568522, -2.521587, -2.808795, 0, 1, 0.9058824, 1,
	    -0.0435737, -0.5130875, -2.809894, 0, 1, 0.9098039, 1,
	    -0.03327388, 2.3027, 0.3513559, 0, 1, 0.9176471, 1,
	    -0.03206522, -1.573056, -3.577499, 0, 1, 0.9215686, 1,
	    -0.0282159, 2.061059, -1.511399, 0, 1, 0.9294118, 1,
	    -0.02530355, 1.424386, 0.1006721, 0, 1, 0.9333333, 1,
	    -0.02484489, 0.4150911, -0.3736403, 0, 1, 0.9411765, 1,
	    -0.02268825, 0.4790212, -0.1889515, 0, 1, 0.945098, 1,
	    -0.02186061, 0.1981996, -0.1838352, 0, 1, 0.9529412, 1,
	    -0.01788781, 0.2548985, 0.8528121, 0, 1, 0.9568627, 1,
	    -0.01754021, 0.01035943, -0.6221234, 0, 1, 0.9647059, 1,
	    -0.0174263, -1.659223, -4.435303, 0, 1, 0.9686275, 1,
	    -0.01576842, 0.1292001, -1.136751, 0, 1, 0.9764706, 1,
	    -0.005287237, 1.807616, -0.7738187, 0, 1, 0.9803922, 1,
	    -0.004497789, -0.4782569, -4.632879, 0, 1, 0.9882353, 1,
	    2.194788e-05, 1.663208, 0.3460592, 0, 1, 0.9921569, 1,
	    3.872261e-05, 0.617376, 0.03226535, 0, 1, 1, 1,
	    0.002078186, 1.062586, -1.782987, 0, 0.9921569, 1, 1,
	    0.00308725, -0.3636467, 2.959177, 0, 0.9882353, 1, 1,
	    0.0034541, -1.713099, 4.88514, 0, 0.9803922, 1, 1,
	    0.003959675, -0.4472571, 3.616592, 0, 0.9764706, 1, 1,
	    0.009248115, -0.8868083, 2.621835, 0, 0.9686275, 1, 1,
	    0.01013542, -0.2122881, 4.335127, 0, 0.9647059, 1, 1,
	    0.01079177, -0.1468041, 4.011078, 0, 0.9568627, 1, 1,
	    0.01107615, 1.617037, 2.667948, 0, 0.9529412, 1, 1,
	    0.01123356, 1.169085, 0.1000001, 0, 0.945098, 1, 1,
	    0.01126085, -0.5901948, 3.392394, 0, 0.9411765, 1, 1,
	    0.01612085, -0.6639568, 5.726636, 0, 0.9333333, 1, 1,
	    0.03426178, -0.1414758, 3.156848, 0, 0.9294118, 1, 1,
	    0.03485145, -1.615834, 5.031162, 0, 0.9215686, 1, 1,
	    0.03567556, -0.7464058, 3.455634, 0, 0.9176471, 1, 1,
	    0.03640075, 0.5217222, -1.89986, 0, 0.9098039, 1, 1,
	    0.0377443, -1.561648, 2.914113, 0, 0.9058824, 1, 1,
	    0.03871078, 0.1095443, -1.163285, 0, 0.8980392, 1, 1,
	    0.0397507, 0.5119005, 2.081023, 0, 0.8901961, 1, 1,
	    0.04127391, 0.5654028, -0.5992858, 0, 0.8862745, 1, 1,
	    0.04144168, -1.146997, 3.596033, 0, 0.8784314, 1, 1,
	    0.05020751, 0.007451753, 2.532369, 0, 0.8745098, 1, 1,
	    0.05421212, -1.092069, 3.95871, 0, 0.8666667, 1, 1,
	    0.05879209, 0.5874898, 0.6320652, 0, 0.8627451, 1, 1,
	    0.06397588, 0.8211659, 0.4069451, 0, 0.854902, 1, 1,
	    0.06402165, 0.3176783, 0.5116262, 0, 0.8509804, 1, 1,
	    0.06518698, -1.003931, 1.903532, 0, 0.8431373, 1, 1,
	    0.06562304, 0.2956593, 0.7092454, 0, 0.8392157, 1, 1,
	    0.06598186, 0.7198603, 0.5380481, 0, 0.8313726, 1, 1,
	    0.06719474, -0.5131022, 5.642786, 0, 0.827451, 1, 1,
	    0.06801462, -1.161318, 2.645651, 0, 0.8196079, 1, 1,
	    0.07203346, -0.6639217, 2.457727, 0, 0.8156863, 1, 1,
	    0.07241027, -0.1419812, 3.038151, 0, 0.8078431, 1, 1,
	    0.07279317, -1.777522, 2.442518, 0, 0.8039216, 1, 1,
	    0.07729056, 1.76293, -0.4462748, 0, 0.7960784, 1, 1,
	    0.0868329, 1.119746, 0.342349, 0, 0.7882353, 1, 1,
	    0.08710591, 0.01287843, 1.160895, 0, 0.7843137, 1, 1,
	    0.08984298, -0.4838952, 1.238859, 0, 0.7764706, 1, 1,
	    0.09019343, 0.4199817, -0.2953859, 0, 0.772549, 1, 1,
	    0.09900268, -0.8379377, 1.944169, 0, 0.7647059, 1, 1,
	    0.1029865, -1.419558, 2.434938, 0, 0.7607843, 1, 1,
	    0.1045099, 0.1149698, -1.373702, 0, 0.7529412, 1, 1,
	    0.1047257, 0.06632658, 0.3736064, 0, 0.7490196, 1, 1,
	    0.1071901, 0.5122936, 0.3810494, 0, 0.7411765, 1, 1,
	    0.1079239, -0.7000562, 4.236815, 0, 0.7372549, 1, 1,
	    0.1102381, 0.4665742, -0.5975201, 0, 0.7294118, 1, 1,
	    0.1110368, 0.33602, 0.3371142, 0, 0.7254902, 1, 1,
	    0.1133948, 0.7831752, -0.7578164, 0, 0.7176471, 1, 1,
	    0.1162791, 0.2579348, 2.959127, 0, 0.7137255, 1, 1,
	    0.1176497, -0.585843, 2.367986, 0, 0.7058824, 1, 1,
	    0.1183031, 0.2788787, 0.5889312, 0, 0.6980392, 1, 1,
	    0.1209479, -0.5406274, 2.650518, 0, 0.6941177, 1, 1,
	    0.1246797, 0.7960976, 2.105573, 0, 0.6862745, 1, 1,
	    0.1282422, 0.6076012, 0.1024433, 0, 0.682353, 1, 1,
	    0.1304156, -1.430341, 3.153082, 0, 0.6745098, 1, 1,
	    0.1329402, -0.523193, 1.844616, 0, 0.6705883, 1, 1,
	    0.1341691, -0.1858745, 1.67725, 0, 0.6627451, 1, 1,
	    0.1381771, 0.3735768, -1.494017, 0, 0.6588235, 1, 1,
	    0.1408373, -0.3683028, 3.403625, 0, 0.6509804, 1, 1,
	    0.1412251, 1.735946, -0.141322, 0, 0.6470588, 1, 1,
	    0.1422952, 1.380871, -0.6098706, 0, 0.6392157, 1, 1,
	    0.1451971, -0.3127098, 2.138732, 0, 0.6352941, 1, 1,
	    0.1455493, 0.516288, 2.774275, 0, 0.627451, 1, 1,
	    0.1500326, -1.643049, 2.573227, 0, 0.6235294, 1, 1,
	    0.1500658, 1.625118, 0.46785, 0, 0.6156863, 1, 1,
	    0.1503568, -1.163252, 3.362991, 0, 0.6117647, 1, 1,
	    0.1508073, -0.482658, 2.589365, 0, 0.6039216, 1, 1,
	    0.1513165, -0.3120277, 3.321861, 0, 0.5960785, 1, 1,
	    0.1539614, -3.01505, 2.898942, 0, 0.5921569, 1, 1,
	    0.1591308, 0.5745289, 0.8666409, 0, 0.5843138, 1, 1,
	    0.1593089, 1.929428, 1.655701, 0, 0.5803922, 1, 1,
	    0.1593632, -0.5490025, 2.92745, 0, 0.572549, 1, 1,
	    0.1613849, 0.2978756, 0.4703769, 0, 0.5686275, 1, 1,
	    0.179752, 0.1564431, 1.559594, 0, 0.5607843, 1, 1,
	    0.1798757, -2.830462, 2.770827, 0, 0.5568628, 1, 1,
	    0.1801367, -0.176859, 2.804807, 0, 0.5490196, 1, 1,
	    0.1816419, -0.09741554, 3.311918, 0, 0.5450981, 1, 1,
	    0.1817762, -3.079396, 2.746766, 0, 0.5372549, 1, 1,
	    0.1832203, 0.1721553, 0.6647133, 0, 0.5333334, 1, 1,
	    0.1884214, 0.3132363, -0.1150755, 0, 0.5254902, 1, 1,
	    0.1923141, -0.4069726, 2.155847, 0, 0.5215687, 1, 1,
	    0.1945627, 1.434348, 0.935501, 0, 0.5137255, 1, 1,
	    0.1951527, 1.825674, -1.834482, 0, 0.509804, 1, 1,
	    0.1969846, 0.6031023, 0.4127749, 0, 0.5019608, 1, 1,
	    0.1980412, 0.2635979, 1.568916, 0, 0.4941176, 1, 1,
	    0.2015796, 0.4214563, 0.3301578, 0, 0.4901961, 1, 1,
	    0.2052553, 1.023125, 0.5433648, 0, 0.4823529, 1, 1,
	    0.2068901, -0.8717617, 2.133257, 0, 0.4784314, 1, 1,
	    0.2093434, -0.3690198, 2.065101, 0, 0.4705882, 1, 1,
	    0.2132994, 2.092016, -2.295503, 0, 0.4666667, 1, 1,
	    0.2136068, 1.300167, 0.8681644, 0, 0.4588235, 1, 1,
	    0.2249686, -2.246898, 3.726065, 0, 0.454902, 1, 1,
	    0.2261895, 1.759211, 0.483188, 0, 0.4470588, 1, 1,
	    0.2307517, 2.396054, -0.1473367, 0, 0.4431373, 1, 1,
	    0.2348337, 1.776447, 1.297071, 0, 0.4352941, 1, 1,
	    0.2416339, 1.442032, -0.03175168, 0, 0.4313726, 1, 1,
	    0.2472818, 0.1173917, 2.975513, 0, 0.4235294, 1, 1,
	    0.2493723, -0.9360744, 1.697286, 0, 0.4196078, 1, 1,
	    0.2526644, -1.252669, 2.940765, 0, 0.4117647, 1, 1,
	    0.2547545, -0.3157407, 2.467894, 0, 0.4078431, 1, 1,
	    0.2584753, 1.732189, 0.2128629, 0, 0.4, 1, 1,
	    0.2616673, -0.3086159, 2.141873, 0, 0.3921569, 1, 1,
	    0.2618734, 0.1555743, 1.426717, 0, 0.3882353, 1, 1,
	    0.2622033, 0.8238528, -0.3308579, 0, 0.3803922, 1, 1,
	    0.2636379, 2.001448, 1.701902, 0, 0.3764706, 1, 1,
	    0.2647451, -2.083519, 3.48564, 0, 0.3686275, 1, 1,
	    0.2650526, 1.75094, 0.3278935, 0, 0.3647059, 1, 1,
	    0.2658502, -0.6129614, 4.132149, 0, 0.3568628, 1, 1,
	    0.2686147, -0.4498299, 1.873266, 0, 0.3529412, 1, 1,
	    0.2717275, -0.4644122, 2.168902, 0, 0.345098, 1, 1,
	    0.2746513, -1.003449, 3.723189, 0, 0.3411765, 1, 1,
	    0.2756839, 0.8042304, 1.227166, 0, 0.3333333, 1, 1,
	    0.2824036, 0.2571312, 0.3136141, 0, 0.3294118, 1, 1,
	    0.2864273, 0.08770391, 2.9694, 0, 0.3215686, 1, 1,
	    0.2884158, 0.3772243, 0.8843765, 0, 0.3176471, 1, 1,
	    0.2886555, -0.2462254, 1.116934, 0, 0.3098039, 1, 1,
	    0.2923025, 0.9842126, 1.991816, 0, 0.3058824, 1, 1,
	    0.2938472, 0.8751948, -0.002399689, 0, 0.2980392, 1, 1,
	    0.2945572, -1.754702, 3.725707, 0, 0.2901961, 1, 1,
	    0.3039449, 0.3431314, 0.193537, 0, 0.2862745, 1, 1,
	    0.3059351, -0.01109467, 0.770114, 0, 0.2784314, 1, 1,
	    0.316653, 0.3225725, -0.4404686, 0, 0.2745098, 1, 1,
	    0.3187934, 0.5699704, 0.3616512, 0, 0.2666667, 1, 1,
	    0.3207699, -0.881288, 2.935745, 0, 0.2627451, 1, 1,
	    0.3246223, 0.1211447, 1.944061, 0, 0.254902, 1, 1,
	    0.3269817, -1.217506, 2.268047, 0, 0.2509804, 1, 1,
	    0.3285469, 0.2610602, 2.321693, 0, 0.2431373, 1, 1,
	    0.3285558, -0.3851984, 4.021317, 0, 0.2392157, 1, 1,
	    0.3304271, -0.07118476, 1.803296, 0, 0.2313726, 1, 1,
	    0.3355799, -0.3383045, 2.483245, 0, 0.227451, 1, 1,
	    0.3366537, 0.1875144, 2.453047, 0, 0.2196078, 1, 1,
	    0.3382444, -0.3560769, 1.450822, 0, 0.2156863, 1, 1,
	    0.342502, -0.1777489, 1.816835, 0, 0.2078431, 1, 1,
	    0.3428313, -0.9657491, 4.018934, 0, 0.2039216, 1, 1,
	    0.3476095, 1.482584, 0.7922444, 0, 0.1960784, 1, 1,
	    0.3516112, -0.09826192, 1.923094, 0, 0.1882353, 1, 1,
	    0.3516999, -0.4805073, 3.146389, 0, 0.1843137, 1, 1,
	    0.3588953, 1.164312, 0.2854097, 0, 0.1764706, 1, 1,
	    0.358983, 0.3054839, 0.5063785, 0, 0.172549, 1, 1,
	    0.3659413, 2.068961, -1.708744, 0, 0.1647059, 1, 1,
	    0.3719188, -0.01508065, 2.36457, 0, 0.1607843, 1, 1,
	    0.3725938, 1.781989, 1.659243, 0, 0.1529412, 1, 1,
	    0.3772391, 0.3874016, 0.3683706, 0, 0.1490196, 1, 1,
	    0.3800778, 0.5271609, 2.253999, 0, 0.1411765, 1, 1,
	    0.3889804, 0.7352558, 1.979467, 0, 0.1372549, 1, 1,
	    0.3919051, 0.193109, 0.3287624, 0, 0.1294118, 1, 1,
	    0.3974673, -0.2649775, 1.375975, 0, 0.1254902, 1, 1,
	    0.3981038, -1.086398, 1.239113, 0, 0.1176471, 1, 1,
	    0.4041904, 1.027313, 0.05860839, 0, 0.1137255, 1, 1,
	    0.4061126, 1.459058, 1.955413, 0, 0.1058824, 1, 1,
	    0.4133861, -0.3437206, 1.250887, 0, 0.09803922, 1, 1,
	    0.413432, 0.9132126, -0.9034853, 0, 0.09411765, 1, 1,
	    0.4154001, 2.068734, 0.2211959, 0, 0.08627451, 1, 1,
	    0.4166882, 0.6657094, 0.8006645, 0, 0.08235294, 1, 1,
	    0.4189253, 0.3298491, 0.5357441, 0, 0.07450981, 1, 1,
	    0.4206451, -0.2916789, 2.02718, 0, 0.07058824, 1, 1,
	    0.4236787, 0.1838421, 1.366093, 0, 0.0627451, 1, 1,
	    0.4246717, 1.029743, 0.6328634, 0, 0.05882353, 1, 1,
	    0.4326732, -0.3080226, 1.795279, 0, 0.05098039, 1, 1,
	    0.4341149, 1.281012, 1.329123, 0, 0.04705882, 1, 1,
	    0.4342516, 0.537141, 1.22171, 0, 0.03921569, 1, 1,
	    0.434638, -0.3640853, 4.33187, 0, 0.03529412, 1, 1,
	    0.4355569, -0.2962773, 2.528921, 0, 0.02745098, 1, 1,
	    0.4398938, -0.2246923, 2.084809, 0, 0.02352941, 1, 1,
	    0.4450382, 0.8301807, -0.6702656, 0, 0.01568628, 1, 1,
	    0.4520915, -0.02221613, 2.111062, 0, 0.01176471, 1, 1,
	    0.4532891, 0.4883922, 1.127643, 0, 0.003921569, 1, 1,
	    0.4593189, 0.6008799, 0.7373096, 0.003921569, 0, 1, 1,
	    0.4608617, 0.3863638, 0.8616354, 0.007843138, 0, 1, 1,
	    0.4614062, 1.573423, 0.8425675, 0.01568628, 0, 1, 1,
	    0.4621343, 0.05329682, 2.149737, 0.01960784, 0, 1, 1,
	    0.4664566, -0.312138, 0.05250165, 0.02745098, 0, 1, 1,
	    0.4738998, 0.2461107, 1.360278, 0.03137255, 0, 1, 1,
	    0.4763683, 1.130494, -0.9810136, 0.03921569, 0, 1, 1,
	    0.4776245, 0.5741035, 2.763366, 0.04313726, 0, 1, 1,
	    0.4839244, -0.5733214, 3.820284, 0.05098039, 0, 1, 1,
	    0.4866119, -0.4662011, 2.671787, 0.05490196, 0, 1, 1,
	    0.4905396, -0.2172164, 1.522645, 0.0627451, 0, 1, 1,
	    0.4939274, 0.2266123, 1.207472, 0.06666667, 0, 1, 1,
	    0.4969344, 0.5156258, 1.061942, 0.07450981, 0, 1, 1,
	    0.4980263, 0.7102857, -0.1229092, 0.07843138, 0, 1, 1,
	    0.499799, 0.7527086, 0.836946, 0.08627451, 0, 1, 1,
	    0.5091153, -0.7662594, 0.7140123, 0.09019608, 0, 1, 1,
	    0.5185859, -0.5641436, 1.845245, 0.09803922, 0, 1, 1,
	    0.5207847, -1.430583, 3.37873, 0.1058824, 0, 1, 1,
	    0.5209183, 1.401483, -0.1563135, 0.1098039, 0, 1, 1,
	    0.5229509, -1.134785, 2.842343, 0.1176471, 0, 1, 1,
	    0.5257801, 0.4417632, 1.570415, 0.1215686, 0, 1, 1,
	    0.5280453, -0.700996, 3.017714, 0.1294118, 0, 1, 1,
	    0.5335397, 0.1045513, -1.029412, 0.1333333, 0, 1, 1,
	    0.5346966, -2.400947, 3.086156, 0.1411765, 0, 1, 1,
	    0.5378201, 0.130746, -0.0495039, 0.145098, 0, 1, 1,
	    0.5389505, -0.5322961, 0.7867286, 0.1529412, 0, 1, 1,
	    0.5393751, -0.8408688, 1.730817, 0.1568628, 0, 1, 1,
	    0.539664, -1.158924, 3.160714, 0.1647059, 0, 1, 1,
	    0.5408447, -0.9128659, 1.796242, 0.1686275, 0, 1, 1,
	    0.5456544, -0.7083116, 1.734176, 0.1764706, 0, 1, 1,
	    0.5459107, -0.6048584, 2.298519, 0.1803922, 0, 1, 1,
	    0.5507053, -0.166944, 3.242611, 0.1882353, 0, 1, 1,
	    0.5539284, 1.876814, -0.7342229, 0.1921569, 0, 1, 1,
	    0.5561756, 0.1270708, 0.09100346, 0.2, 0, 1, 1,
	    0.5594358, 0.8005657, -0.8218408, 0.2078431, 0, 1, 1,
	    0.5598118, 1.815516, 0.2296297, 0.2117647, 0, 1, 1,
	    0.5645132, -0.3241752, 2.131581, 0.2196078, 0, 1, 1,
	    0.5694851, 2.002535, 1.40832, 0.2235294, 0, 1, 1,
	    0.570828, 0.3242564, 2.837196, 0.2313726, 0, 1, 1,
	    0.571831, -0.2980584, 0.4675678, 0.2352941, 0, 1, 1,
	    0.572806, 0.125244, 1.402753, 0.2431373, 0, 1, 1,
	    0.5839306, 0.1438777, 2.077825, 0.2470588, 0, 1, 1,
	    0.5887602, -1.702862, 1.418824, 0.254902, 0, 1, 1,
	    0.5898232, 0.4341567, 0.6203216, 0.2588235, 0, 1, 1,
	    0.5940751, -1.398982, 4.235255, 0.2666667, 0, 1, 1,
	    0.5988467, -1.054414, 1.924572, 0.2705882, 0, 1, 1,
	    0.6002509, 0.4094629, 0.4629644, 0.2784314, 0, 1, 1,
	    0.6023952, -1.313403, 3.916677, 0.282353, 0, 1, 1,
	    0.6057612, -0.3588452, 2.732943, 0.2901961, 0, 1, 1,
	    0.6079558, -1.287849, 3.478622, 0.2941177, 0, 1, 1,
	    0.6133147, 0.3546236, 0.7862302, 0.3019608, 0, 1, 1,
	    0.6164545, -0.5021322, 1.55729, 0.3098039, 0, 1, 1,
	    0.6205727, 1.65481, 3.540257, 0.3137255, 0, 1, 1,
	    0.6246306, -1.351326, 2.837086, 0.3215686, 0, 1, 1,
	    0.6313875, 2.068227, 0.794889, 0.3254902, 0, 1, 1,
	    0.6334655, -1.314749, 0.790665, 0.3333333, 0, 1, 1,
	    0.6409981, -1.457851, 1.746603, 0.3372549, 0, 1, 1,
	    0.6411284, 0.1192357, 0.6803393, 0.345098, 0, 1, 1,
	    0.6412485, 0.3650267, 2.058064, 0.3490196, 0, 1, 1,
	    0.6433551, 1.249007, -0.285668, 0.3568628, 0, 1, 1,
	    0.6454383, 0.4662233, 2.11718, 0.3607843, 0, 1, 1,
	    0.6476038, -0.2086138, 2.669163, 0.3686275, 0, 1, 1,
	    0.6499786, 0.7525759, 0.9822037, 0.372549, 0, 1, 1,
	    0.6521316, 1.980212, -0.03718061, 0.3803922, 0, 1, 1,
	    0.6530758, -0.4620588, 2.408462, 0.3843137, 0, 1, 1,
	    0.6609166, 0.4451295, 4.089514, 0.3921569, 0, 1, 1,
	    0.6666743, 0.2758922, 3.248261, 0.3960784, 0, 1, 1,
	    0.6681364, 0.637709, -0.1640552, 0.4039216, 0, 1, 1,
	    0.6700203, -0.6032799, 2.656305, 0.4117647, 0, 1, 1,
	    0.67073, 0.05203446, 3.410367, 0.4156863, 0, 1, 1,
	    0.6837447, 0.6409311, 0.1450121, 0.4235294, 0, 1, 1,
	    0.6845177, 0.8545278, -0.6374082, 0.427451, 0, 1, 1,
	    0.6873155, -1.016876, 1.287946, 0.4352941, 0, 1, 1,
	    0.6895891, -0.9586263, 3.187018, 0.4392157, 0, 1, 1,
	    0.6917729, 1.427838, -1.151495, 0.4470588, 0, 1, 1,
	    0.6920067, 0.4569274, 0.7899799, 0.4509804, 0, 1, 1,
	    0.6942951, 0.02009179, 1.636885, 0.4588235, 0, 1, 1,
	    0.699183, -0.49092, 0.8308169, 0.4627451, 0, 1, 1,
	    0.7020348, 0.3075933, 2.303733, 0.4705882, 0, 1, 1,
	    0.7041515, -0.313928, 2.684404, 0.4745098, 0, 1, 1,
	    0.7046159, -0.2178514, 1.535181, 0.4823529, 0, 1, 1,
	    0.7134906, -1.008547, 2.688775, 0.4862745, 0, 1, 1,
	    0.7153398, 0.3947908, -0.07182045, 0.4941176, 0, 1, 1,
	    0.7238891, -0.326073, 1.633375, 0.5019608, 0, 1, 1,
	    0.7267268, 1.125671, 0.6727903, 0.5058824, 0, 1, 1,
	    0.7269244, -1.736594, 3.232759, 0.5137255, 0, 1, 1,
	    0.7309943, -0.2133387, 2.22665, 0.5176471, 0, 1, 1,
	    0.7310414, 1.061083, 0.1841511, 0.5254902, 0, 1, 1,
	    0.7315769, 0.224728, 1.176181, 0.5294118, 0, 1, 1,
	    0.7337611, -2.355911, 3.235239, 0.5372549, 0, 1, 1,
	    0.7359368, 0.9158477, 1.139281, 0.5411765, 0, 1, 1,
	    0.7426862, -0.4107747, 4.030119, 0.5490196, 0, 1, 1,
	    0.7457897, 0.1398423, 1.365883, 0.5529412, 0, 1, 1,
	    0.7458171, -0.4199912, 1.993166, 0.5607843, 0, 1, 1,
	    0.7459446, 0.9931608, 1.737822, 0.5647059, 0, 1, 1,
	    0.7554311, 0.3869634, -0.4667729, 0.572549, 0, 1, 1,
	    0.7571295, 0.7933447, 0.4895405, 0.5764706, 0, 1, 1,
	    0.7581335, 0.6407917, -0.2426542, 0.5843138, 0, 1, 1,
	    0.7588633, 1.215781, 0.09899816, 0.5882353, 0, 1, 1,
	    0.7591736, -1.358372, 3.197734, 0.5960785, 0, 1, 1,
	    0.7598002, 0.5631582, -0.8183959, 0.6039216, 0, 1, 1,
	    0.7608465, -0.7249228, 4.744511, 0.6078432, 0, 1, 1,
	    0.7629351, -0.3664422, 2.594641, 0.6156863, 0, 1, 1,
	    0.7632569, 0.04011446, 1.402348, 0.6196079, 0, 1, 1,
	    0.7665361, 0.3809331, 1.797963, 0.627451, 0, 1, 1,
	    0.766849, 0.444258, 0.8629856, 0.6313726, 0, 1, 1,
	    0.7721435, -1.055676, 2.346676, 0.6392157, 0, 1, 1,
	    0.7723507, -0.6766473, 3.70608, 0.6431373, 0, 1, 1,
	    0.7728675, 0.3221478, 2.643107, 0.6509804, 0, 1, 1,
	    0.7861386, -0.4550921, 3.646589, 0.654902, 0, 1, 1,
	    0.787922, -1.311146, 0.9929941, 0.6627451, 0, 1, 1,
	    0.7927755, 1.431599, 0.01006958, 0.6666667, 0, 1, 1,
	    0.7929832, -0.2048452, 1.599848, 0.6745098, 0, 1, 1,
	    0.7953127, -0.2045782, 0.9350173, 0.6784314, 0, 1, 1,
	    0.7964038, -1.736903, 0.9153795, 0.6862745, 0, 1, 1,
	    0.7976894, -1.6583, 3.982257, 0.6901961, 0, 1, 1,
	    0.7979798, -0.3660344, 1.823509, 0.6980392, 0, 1, 1,
	    0.8056912, 0.7068547, 0.4148237, 0.7058824, 0, 1, 1,
	    0.8059747, -1.206786, 3.108876, 0.7098039, 0, 1, 1,
	    0.8129446, 1.168002, 0.1299869, 0.7176471, 0, 1, 1,
	    0.8156769, 0.77982, 0.8965, 0.7215686, 0, 1, 1,
	    0.816611, -1.654689, 3.821391, 0.7294118, 0, 1, 1,
	    0.8172996, -0.8858189, 2.145869, 0.7333333, 0, 1, 1,
	    0.8188244, 2.262455, 1.199317, 0.7411765, 0, 1, 1,
	    0.8236441, 1.388849, 0.7497305, 0.7450981, 0, 1, 1,
	    0.8279375, 0.365781, 0.7161816, 0.7529412, 0, 1, 1,
	    0.8387162, 0.168154, -0.1563699, 0.7568628, 0, 1, 1,
	    0.8403135, -0.253396, 2.854348, 0.7647059, 0, 1, 1,
	    0.8416305, 0.407364, 0.4940232, 0.7686275, 0, 1, 1,
	    0.8450461, 1.294317, 0.4478051, 0.7764706, 0, 1, 1,
	    0.8531113, 0.9727371, 0.6674333, 0.7803922, 0, 1, 1,
	    0.8532134, -1.171338, 3.336207, 0.7882353, 0, 1, 1,
	    0.8640292, 0.3360007, 2.56887, 0.7921569, 0, 1, 1,
	    0.8718342, -2.4161, 1.322513, 0.8, 0, 1, 1,
	    0.877646, -0.5255159, 4.598061, 0.8078431, 0, 1, 1,
	    0.8781888, 0.2983386, 0.2585032, 0.8117647, 0, 1, 1,
	    0.8799745, -1.028812, 2.670196, 0.8196079, 0, 1, 1,
	    0.8825271, 0.9408849, 1.149411, 0.8235294, 0, 1, 1,
	    0.8837414, -1.085307, 2.597369, 0.8313726, 0, 1, 1,
	    0.890006, 1.492511, 0.2184942, 0.8352941, 0, 1, 1,
	    0.8974494, 0.4001951, 1.337247, 0.8431373, 0, 1, 1,
	    0.9001282, -1.050565, 1.764137, 0.8470588, 0, 1, 1,
	    0.9009241, 1.956787, -0.8263922, 0.854902, 0, 1, 1,
	    0.9077621, -1.538427, 2.158779, 0.8588235, 0, 1, 1,
	    0.9109487, -0.1647783, 2.313425, 0.8666667, 0, 1, 1,
	    0.9110559, 0.8489202, -1.256134, 0.8705882, 0, 1, 1,
	    0.9220062, -1.754617, 1.008741, 0.8784314, 0, 1, 1,
	    0.9227504, -0.4647248, 1.638605, 0.8823529, 0, 1, 1,
	    0.9259602, -0.02236581, 1.799479, 0.8901961, 0, 1, 1,
	    0.9358597, 0.1093779, 2.599617, 0.8941177, 0, 1, 1,
	    0.938397, 0.322954, 1.30283, 0.9019608, 0, 1, 1,
	    0.9416828, 2.357248, -0.5743691, 0.9098039, 0, 1, 1,
	    0.9424602, 0.2403536, 1.260242, 0.9137255, 0, 1, 1,
	    0.9470561, 0.3002994, 0.8741249, 0.9215686, 0, 1, 1,
	    0.9534995, -0.006037371, 2.117933, 0.9254902, 0, 1, 1,
	    0.9546471, -0.9374786, 2.258131, 0.9333333, 0, 1, 1,
	    0.9550763, 1.068185, 2.904915, 0.9372549, 0, 1, 1,
	    0.9583192, -1.682886, 2.721329, 0.945098, 0, 1, 1,
	    0.9647921, 0.5156032, 0.175233, 0.9490196, 0, 1, 1,
	    0.9678848, 0.09728671, 1.971361, 0.9568627, 0, 1, 1,
	    0.9681822, 0.1032186, 1.534012, 0.9607843, 0, 1, 1,
	    0.9721016, 0.06368063, 1.034448, 0.9686275, 0, 1, 1,
	    0.9772213, 1.425222, -0.373971, 0.972549, 0, 1, 1,
	    0.9787003, -0.8026216, 2.838175, 0.9803922, 0, 1, 1,
	    0.9804758, -0.2171521, 0.5650147, 0.9843137, 0, 1, 1,
	    0.9900292, 1.272115, 1.718536, 0.9921569, 0, 1, 1,
	    0.9929172, 1.708091, 0.4198323, 0.9960784, 0, 1, 1,
	    0.9951916, 2.045274, 0.6201676, 1, 0, 0.9960784, 1,
	    0.9964104, -0.9127778, 0.8417657, 1, 0, 0.9882353, 1,
	    0.9966612, -1.71894, 1.519565, 1, 0, 0.9843137, 1,
	    0.9969358, 0.9630951, 0.5534772, 1, 0, 0.9764706, 1,
	    0.9969667, -0.8675967, 4.064746, 1, 0, 0.972549, 1,
	    0.9994617, -0.2280219, 1.746245, 1, 0, 0.9647059, 1,
	    1.002181, 0.3869628, 2.106987, 1, 0, 0.9607843, 1,
	    1.00818, -1.801401, 1.80845, 1, 0, 0.9529412, 1,
	    1.009695, -1.089684, 3.093114, 1, 0, 0.9490196, 1,
	    1.020959, -0.5735884, 0.7180806, 1, 0, 0.9411765, 1,
	    1.022467, -0.2603695, 0.7528349, 1, 0, 0.9372549, 1,
	    1.03087, 0.2198069, 1.226863, 1, 0, 0.9294118, 1,
	    1.034935, 0.6967148, 0.0672668, 1, 0, 0.9254902, 1,
	    1.037132, 2.043251, -0.6851089, 1, 0, 0.9176471, 1,
	    1.037251, 0.3511457, 0.4420679, 1, 0, 0.9137255, 1,
	    1.051255, -0.178478, 2.720975, 1, 0, 0.9058824, 1,
	    1.060014, 0.2579198, 0.8107343, 1, 0, 0.9019608, 1,
	    1.06127, 1.759872, -0.2319966, 1, 0, 0.8941177, 1,
	    1.067092, -1.61187, -0.4827314, 1, 0, 0.8862745, 1,
	    1.068959, 0.2285355, 0.4613349, 1, 0, 0.8823529, 1,
	    1.07238, -0.2532513, 2.745922, 1, 0, 0.8745098, 1,
	    1.081468, -1.03921, 2.240465, 1, 0, 0.8705882, 1,
	    1.083791, 1.374359, 2.154761, 1, 0, 0.8627451, 1,
	    1.105458, -0.04856004, 3.651619, 1, 0, 0.8588235, 1,
	    1.114817, 0.1188806, 0.8366519, 1, 0, 0.8509804, 1,
	    1.117096, 0.5340874, 2.35648, 1, 0, 0.8470588, 1,
	    1.119107, -0.6607662, 1.046937, 1, 0, 0.8392157, 1,
	    1.119483, -1.058227, 2.494067, 1, 0, 0.8352941, 1,
	    1.127764, -0.1532642, 0.4144047, 1, 0, 0.827451, 1,
	    1.149097, 0.7723969, 0.7150037, 1, 0, 0.8235294, 1,
	    1.157992, 0.4347859, 2.220109, 1, 0, 0.8156863, 1,
	    1.16018, -1.357386, 2.676372, 1, 0, 0.8117647, 1,
	    1.16115, 1.188234, -0.6636821, 1, 0, 0.8039216, 1,
	    1.161742, 0.5123668, 1.733246, 1, 0, 0.7960784, 1,
	    1.165385, 0.3952523, 1.633824, 1, 0, 0.7921569, 1,
	    1.166305, 0.07591937, 2.695394, 1, 0, 0.7843137, 1,
	    1.171572, -1.129247, 3.635922, 1, 0, 0.7803922, 1,
	    1.180593, -1.65587, 2.94245, 1, 0, 0.772549, 1,
	    1.194311, 0.6328349, -0.08530097, 1, 0, 0.7686275, 1,
	    1.196449, 0.6826021, 1.256127, 1, 0, 0.7607843, 1,
	    1.203493, 1.442212, 0.6739343, 1, 0, 0.7568628, 1,
	    1.208758, 0.761746, 1.003817, 1, 0, 0.7490196, 1,
	    1.212931, -0.03273994, 1.596483, 1, 0, 0.7450981, 1,
	    1.213202, -0.3092571, 2.95952, 1, 0, 0.7372549, 1,
	    1.243127, -1.027639, 3.040386, 1, 0, 0.7333333, 1,
	    1.245816, 0.4595264, 2.728359, 1, 0, 0.7254902, 1,
	    1.266977, 1.165375, -0.1197713, 1, 0, 0.7215686, 1,
	    1.267911, 1.331082, 2.186464, 1, 0, 0.7137255, 1,
	    1.269967, 0.1933316, 1.67996, 1, 0, 0.7098039, 1,
	    1.276776, -1.340682, 4.531163, 1, 0, 0.7019608, 1,
	    1.284834, -0.2964297, 1.492743, 1, 0, 0.6941177, 1,
	    1.285294, 1.46174, 0.4047556, 1, 0, 0.6901961, 1,
	    1.287387, 0.5268384, 1.663475, 1, 0, 0.682353, 1,
	    1.289919, -1.377109, 2.139475, 1, 0, 0.6784314, 1,
	    1.290032, 0.101339, 2.370909, 1, 0, 0.6705883, 1,
	    1.299445, 0.3564847, 0.6633544, 1, 0, 0.6666667, 1,
	    1.300361, -0.2322712, 1.791373, 1, 0, 0.6588235, 1,
	    1.308195, 1.354363, 1.997096, 1, 0, 0.654902, 1,
	    1.309604, 0.383455, 0.180327, 1, 0, 0.6470588, 1,
	    1.311803, 0.3143148, 1.366718, 1, 0, 0.6431373, 1,
	    1.315758, 1.165163, 2.143846, 1, 0, 0.6352941, 1,
	    1.318001, -0.3349987, 0.4273521, 1, 0, 0.6313726, 1,
	    1.322492, 0.4210496, 0.01602428, 1, 0, 0.6235294, 1,
	    1.336639, 1.649144, -0.1032015, 1, 0, 0.6196079, 1,
	    1.346264, -2.342581, 2.664506, 1, 0, 0.6117647, 1,
	    1.358703, -0.8745727, 3.035419, 1, 0, 0.6078432, 1,
	    1.367212, 0.3253539, 1.254045, 1, 0, 0.6, 1,
	    1.369256, 1.486736, -1.16159, 1, 0, 0.5921569, 1,
	    1.375485, -1.276165, 1.252755, 1, 0, 0.5882353, 1,
	    1.378448, -0.8698762, 0.6684532, 1, 0, 0.5803922, 1,
	    1.386031, -0.907146, 1.860381, 1, 0, 0.5764706, 1,
	    1.394682, -1.3109, 1.91466, 1, 0, 0.5686275, 1,
	    1.406544, -0.4719117, 2.868997, 1, 0, 0.5647059, 1,
	    1.407187, -0.347908, 3.901073, 1, 0, 0.5568628, 1,
	    1.40892, 0.8881238, 0.267911, 1, 0, 0.5529412, 1,
	    1.410348, -0.7899956, 1.2055, 1, 0, 0.5450981, 1,
	    1.417941, -1.921914, 3.74532, 1, 0, 0.5411765, 1,
	    1.418976, -1.228485, 2.937975, 1, 0, 0.5333334, 1,
	    1.422165, 0.5083261, 1.550701, 1, 0, 0.5294118, 1,
	    1.430732, 0.8451664, 1.643803, 1, 0, 0.5215687, 1,
	    1.43948, 1.415914, 1.464558, 1, 0, 0.5176471, 1,
	    1.441678, -0.8693639, 2.465812, 1, 0, 0.509804, 1,
	    1.446517, 1.02105, 2.100566, 1, 0, 0.5058824, 1,
	    1.44901, 2.113568, 0.1229412, 1, 0, 0.4980392, 1,
	    1.473116, -1.239294, 2.086343, 1, 0, 0.4901961, 1,
	    1.480544, -0.6554889, 1.673707, 1, 0, 0.4862745, 1,
	    1.497035, 0.90237, 2.876473, 1, 0, 0.4784314, 1,
	    1.504301, -0.2031999, 1.755426, 1, 0, 0.4745098, 1,
	    1.514623, 1.817895, 1.336884, 1, 0, 0.4666667, 1,
	    1.521091, -0.05258167, 2.868309, 1, 0, 0.4627451, 1,
	    1.524627, 0.12092, 1.370921, 1, 0, 0.454902, 1,
	    1.530927, 0.3965172, 1.589138, 1, 0, 0.4509804, 1,
	    1.535604, -0.07173274, -1.10794, 1, 0, 0.4431373, 1,
	    1.547215, -1.060986, 1.351011, 1, 0, 0.4392157, 1,
	    1.556152, 0.3669614, 0.2066714, 1, 0, 0.4313726, 1,
	    1.55988, -1.504182, 2.949312, 1, 0, 0.427451, 1,
	    1.562118, -0.5947963, 2.906344, 1, 0, 0.4196078, 1,
	    1.565287, -1.943856, 1.155047, 1, 0, 0.4156863, 1,
	    1.565614, 0.750768, -0.5039493, 1, 0, 0.4078431, 1,
	    1.568202, 0.01701231, 2.840806, 1, 0, 0.4039216, 1,
	    1.591284, 1.594231, 0.5496263, 1, 0, 0.3960784, 1,
	    1.605354, 0.0742381, 1.952461, 1, 0, 0.3882353, 1,
	    1.608026, 0.004077848, 2.039271, 1, 0, 0.3843137, 1,
	    1.619217, 0.4370612, 0.168545, 1, 0, 0.3764706, 1,
	    1.619857, 0.2679184, 0.3383442, 1, 0, 0.372549, 1,
	    1.646624, 0.5717301, 2.801625, 1, 0, 0.3647059, 1,
	    1.647443, -0.6751638, 2.7261, 1, 0, 0.3607843, 1,
	    1.655, 1.627695, 0.8597155, 1, 0, 0.3529412, 1,
	    1.656103, 0.6107309, 1.600678, 1, 0, 0.3490196, 1,
	    1.663523, 1.162282, 0.1575588, 1, 0, 0.3411765, 1,
	    1.676202, 0.7306763, 1.530846, 1, 0, 0.3372549, 1,
	    1.679866, 2.373007, 0.3386082, 1, 0, 0.3294118, 1,
	    1.681786, 2.249422, 0.730181, 1, 0, 0.3254902, 1,
	    1.686015, -0.7122685, 1.344443, 1, 0, 0.3176471, 1,
	    1.702485, -1.225805, 2.739908, 1, 0, 0.3137255, 1,
	    1.703503, -0.8034666, 3.74429, 1, 0, 0.3058824, 1,
	    1.712178, 1.076942, 0.6586438, 1, 0, 0.2980392, 1,
	    1.719875, 0.08333985, 3.320227, 1, 0, 0.2941177, 1,
	    1.729099, -1.957484, 3.770182, 1, 0, 0.2862745, 1,
	    1.729527, 0.4729107, 1.43466, 1, 0, 0.282353, 1,
	    1.734939, -0.2129533, 1.087465, 1, 0, 0.2745098, 1,
	    1.749666, -1.733961, 0.3135422, 1, 0, 0.2705882, 1,
	    1.76126, 0.1526931, 0.8638607, 1, 0, 0.2627451, 1,
	    1.812328, 0.5666555, 2.164482, 1, 0, 0.2588235, 1,
	    1.832297, 0.01339024, 0.01944265, 1, 0, 0.2509804, 1,
	    1.840721, 1.432132, 0.6131299, 1, 0, 0.2470588, 1,
	    1.853093, 0.204783, -0.1235347, 1, 0, 0.2392157, 1,
	    1.856269, -0.02591823, 1.58742, 1, 0, 0.2352941, 1,
	    1.857355, -1.156527, 3.656885, 1, 0, 0.227451, 1,
	    1.858567, -0.0130629, 1.756478, 1, 0, 0.2235294, 1,
	    1.864356, 1.241836, -0.9863899, 1, 0, 0.2156863, 1,
	    1.870555, 1.622315, 1.241132, 1, 0, 0.2117647, 1,
	    1.874395, -1.358309, 1.049442, 1, 0, 0.2039216, 1,
	    1.886871, -1.119787, 2.262472, 1, 0, 0.1960784, 1,
	    1.912747, 1.768518, 1.034497, 1, 0, 0.1921569, 1,
	    1.928954, 0.776777, 0.5292309, 1, 0, 0.1843137, 1,
	    1.929945, 0.8749858, 0.8507446, 1, 0, 0.1803922, 1,
	    1.93064, 1.498396, 1.987762, 1, 0, 0.172549, 1,
	    1.963416, -0.08349141, 2.701329, 1, 0, 0.1686275, 1,
	    1.971303, 0.2311523, -0.06288517, 1, 0, 0.1607843, 1,
	    1.975772, -0.4563044, 0.1877021, 1, 0, 0.1568628, 1,
	    1.990204, 0.3570535, 2.821983, 1, 0, 0.1490196, 1,
	    2.011484, -0.1148927, 1.468052, 1, 0, 0.145098, 1,
	    2.020014, -1.748384, 2.742794, 1, 0, 0.1372549, 1,
	    2.051158, -0.5673112, 1.943195, 1, 0, 0.1333333, 1,
	    2.051498, 1.853096, -0.2360891, 1, 0, 0.1254902, 1,
	    2.117946, -0.3454867, -0.1088733, 1, 0, 0.1215686, 1,
	    2.119942, 0.5759858, 0.8342041, 1, 0, 0.1137255, 1,
	    2.213695, 0.2318297, 1.216222, 1, 0, 0.1098039, 1,
	    2.218627, -0.1232664, 2.961774, 1, 0, 0.1019608, 1,
	    2.21872, 0.5662271, 2.152424, 1, 0, 0.09411765, 1,
	    2.241197, 0.6550197, 1.552182, 1, 0, 0.09019608, 1,
	    2.360102, 1.32649, 1.625831, 1, 0, 0.08235294, 1,
	    2.390313, 0.3086386, 2.500716, 1, 0, 0.07843138, 1,
	    2.437252, -0.2455915, 1.696822, 1, 0, 0.07058824, 1,
	    2.447481, -0.8071147, 3.927218, 1, 0, 0.06666667, 1,
	    2.463862, 0.4327462, 0.3726169, 1, 0, 0.05882353, 1,
	    2.471322, -0.2254537, 2.56032, 1, 0, 0.05490196, 1,
	    2.543713, 0.7862731, 1.362914, 1, 0, 0.04705882, 1,
	    2.608255, -1.390757, 2.706708, 1, 0, 0.04313726, 1,
	    2.752213, -2.000364, 2.918674, 1, 0, 0.03529412, 1,
	    2.932766, 1.07992, 2.589986, 1, 0, 0.03137255, 1,
	    3.063232, 0.6793596, 1.852117, 1, 0, 0.02352941, 1,
	    3.235403, 0.2231721, 2.034507, 1, 0, 0.01960784, 1,
	    3.292051, 0.3319722, 3.788687, 1, 0, 0.01176471, 1,
	    3.306546, 0.5703415, -0.1811764, 1, 0, 0.007843138, 1
	   ]);
	   var buf6 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf6);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc6 = gl.getUniformLocation(prog6,"mvMatrix");
                  var prMatLoc6 = gl.getUniformLocation(prog6,"prMatrix");
      // ****** text object 8 ******
	   var prog8  = gl.createProgram();
        gl.attachShader(prog8, this.getShader( gl, "bivarvshader8" ));
        gl.attachShader(prog8, this.getShader( gl, "bivarfshader8" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog8, 0, "aPos");
        gl.bindAttribLocation(prog8, 1, "aCol");
        gl.linkProgram(prog8);
	   var texts = [
	    "x"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
                    var canvasX8 = texinfo.canvasX;
                    var canvasY8 = texinfo.canvasY;
	   var ofsLoc8 = gl.getAttribLocation(prog8, "aOfs");
	   var texture8 = gl.createTexture();
      var texLoc8 = gl.getAttribLocation(prog8, "aTexcoord");
      var sampler8 = gl.getUniformLocation(prog8,"uSampler");
    	   handleLoadedTexture(texture8, document.getElementById("bivartextureCanvas"));
	   var v=new Float32Array([
	    -0.006550431, -4.230728, -7.242525, 0, -0.5, 0.5, 0.5,
	    -0.006550431, -4.230728, -7.242525, 1, -0.5, 0.5, 0.5,
	    -0.006550431, -4.230728, -7.242525, 1, 1.5, 0.5, 0.5,
	    -0.006550431, -4.230728, -7.242525, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
                  for (var j=0; j<4; j++) {
                  ind = 7*(4*i + j) + 3;
                  v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
                  v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
                  v[ind] *= texinfo.widths[i]/texinfo.canvasX;
                  v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
                  - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
                  }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf8 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf8);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf8 = gl.createBuffer();
                  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf8);
                  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc8 = gl.getUniformLocation(prog8,"mvMatrix");
                  var prMatLoc8 = gl.getUniformLocation(prog8,"prMatrix");
      // ****** text object 9 ******
	   var prog9  = gl.createProgram();
        gl.attachShader(prog9, this.getShader( gl, "bivarvshader9" ));
        gl.attachShader(prog9, this.getShader( gl, "bivarfshader9" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog9, 0, "aPos");
        gl.bindAttribLocation(prog9, 1, "aCol");
        gl.linkProgram(prog9);
	   var texts = [
	    "y"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
                    var canvasX9 = texinfo.canvasX;
                    var canvasY9 = texinfo.canvasY;
	   var ofsLoc9 = gl.getAttribLocation(prog9, "aOfs");
	   var texture9 = gl.createTexture();
      var texLoc9 = gl.getAttribLocation(prog9, "aTexcoord");
      var sampler9 = gl.getUniformLocation(prog9,"uSampler");
    	   handleLoadedTexture(texture9, document.getElementById("bivartextureCanvas"));
	   var v=new Float32Array([
	    -4.442786, 0.3168646, -7.242525, 0, -0.5, 0.5, 0.5,
	    -4.442786, 0.3168646, -7.242525, 1, -0.5, 0.5, 0.5,
	    -4.442786, 0.3168646, -7.242525, 1, 1.5, 0.5, 0.5,
	    -4.442786, 0.3168646, -7.242525, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
                  for (var j=0; j<4; j++) {
                  ind = 7*(4*i + j) + 3;
                  v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
                  v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
                  v[ind] *= texinfo.widths[i]/texinfo.canvasX;
                  v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
                  - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
                  }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf9 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf9);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf9 = gl.createBuffer();
                  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf9);
                  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc9 = gl.getUniformLocation(prog9,"mvMatrix");
                  var prMatLoc9 = gl.getUniformLocation(prog9,"prMatrix");
      // ****** text object 10 ******
	   var prog10  = gl.createProgram();
        gl.attachShader(prog10, this.getShader( gl, "bivarvshader10" ));
        gl.attachShader(prog10, this.getShader( gl, "bivarfshader10" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog10, 0, "aPos");
        gl.bindAttribLocation(prog10, 1, "aCol");
        gl.linkProgram(prog10);
	   var texts = [
	    "z"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
                    var canvasX10 = texinfo.canvasX;
                    var canvasY10 = texinfo.canvasY;
	   var ofsLoc10 = gl.getAttribLocation(prog10, "aOfs");
	   var texture10 = gl.createTexture();
      var texLoc10 = gl.getAttribLocation(prog10, "aTexcoord");
      var sampler10 = gl.getUniformLocation(prog10,"uSampler");
    	   handleLoadedTexture(texture10, document.getElementById("bivartextureCanvas"));
	   var v=new Float32Array([
	    -4.442786, -4.230728, 0.1818898, 0, -0.5, 0.5, 0.5,
	    -4.442786, -4.230728, 0.1818898, 1, -0.5, 0.5, 0.5,
	    -4.442786, -4.230728, 0.1818898, 1, 1.5, 0.5, 0.5,
	    -4.442786, -4.230728, 0.1818898, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<1; i++) 
                  for (var j=0; j<4; j++) {
                  ind = 7*(4*i + j) + 3;
                  v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
                  v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
                  v[ind] *= texinfo.widths[i]/texinfo.canvasX;
                  v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
                  - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
                  }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3
	   ]);
	   var buf10 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf10);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf10 = gl.createBuffer();
                  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf10);
                  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc10 = gl.getUniformLocation(prog10,"mvMatrix");
                  var prMatLoc10 = gl.getUniformLocation(prog10,"prMatrix");
      // ****** lines object 11 ******
	   var prog11  = gl.createProgram();
        gl.attachShader(prog11, this.getShader( gl, "bivarvshader11" ));
        gl.attachShader(prog11, this.getShader( gl, "bivarfshader11" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog11, 0, "aPos");
        gl.bindAttribLocation(prog11, 1, "aCol");
        gl.linkProgram(prog11);
	   var v=new Float32Array([
	    -3, -3.181283, -5.529199,
	    3, -3.181283, -5.529199,
	    -3, -3.181283, -5.529199,
	    -3, -3.356191, -5.814753,
	    -2, -3.181283, -5.529199,
	    -2, -3.356191, -5.814753,
	    -1, -3.181283, -5.529199,
	    -1, -3.356191, -5.814753,
	    0, -3.181283, -5.529199,
	    0, -3.356191, -5.814753,
	    1, -3.181283, -5.529199,
	    1, -3.356191, -5.814753,
	    2, -3.181283, -5.529199,
	    2, -3.356191, -5.814753,
	    3, -3.181283, -5.529199,
	    3, -3.356191, -5.814753
	   ]);
	   var buf11 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf11);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc11 = gl.getUniformLocation(prog11,"mvMatrix");
                  var prMatLoc11 = gl.getUniformLocation(prog11,"prMatrix");
      // ****** text object 12 ******
	   var prog12  = gl.createProgram();
        gl.attachShader(prog12, this.getShader( gl, "bivarvshader12" ));
        gl.attachShader(prog12, this.getShader( gl, "bivarfshader12" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog12, 0, "aPos");
        gl.bindAttribLocation(prog12, 1, "aCol");
        gl.linkProgram(prog12);
	   var texts = [
	    "-3",
	    "-2",
	    "-1",
	    "0",
	    "1",
	    "2",
	    "3"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
                    var canvasX12 = texinfo.canvasX;
                    var canvasY12 = texinfo.canvasY;
	   var ofsLoc12 = gl.getAttribLocation(prog12, "aOfs");
	   var texture12 = gl.createTexture();
      var texLoc12 = gl.getAttribLocation(prog12, "aTexcoord");
      var sampler12 = gl.getUniformLocation(prog12,"uSampler");
    	   handleLoadedTexture(texture12, document.getElementById("bivartextureCanvas"));
	   var v=new Float32Array([
	    -3, -3.706006, -6.385862, 0, -0.5, 0.5, 0.5,
	    -3, -3.706006, -6.385862, 1, -0.5, 0.5, 0.5,
	    -3, -3.706006, -6.385862, 1, 1.5, 0.5, 0.5,
	    -3, -3.706006, -6.385862, 0, 1.5, 0.5, 0.5,
	    -2, -3.706006, -6.385862, 0, -0.5, 0.5, 0.5,
	    -2, -3.706006, -6.385862, 1, -0.5, 0.5, 0.5,
	    -2, -3.706006, -6.385862, 1, 1.5, 0.5, 0.5,
	    -2, -3.706006, -6.385862, 0, 1.5, 0.5, 0.5,
	    -1, -3.706006, -6.385862, 0, -0.5, 0.5, 0.5,
	    -1, -3.706006, -6.385862, 1, -0.5, 0.5, 0.5,
	    -1, -3.706006, -6.385862, 1, 1.5, 0.5, 0.5,
	    -1, -3.706006, -6.385862, 0, 1.5, 0.5, 0.5,
	    0, -3.706006, -6.385862, 0, -0.5, 0.5, 0.5,
	    0, -3.706006, -6.385862, 1, -0.5, 0.5, 0.5,
	    0, -3.706006, -6.385862, 1, 1.5, 0.5, 0.5,
	    0, -3.706006, -6.385862, 0, 1.5, 0.5, 0.5,
	    1, -3.706006, -6.385862, 0, -0.5, 0.5, 0.5,
	    1, -3.706006, -6.385862, 1, -0.5, 0.5, 0.5,
	    1, -3.706006, -6.385862, 1, 1.5, 0.5, 0.5,
	    1, -3.706006, -6.385862, 0, 1.5, 0.5, 0.5,
	    2, -3.706006, -6.385862, 0, -0.5, 0.5, 0.5,
	    2, -3.706006, -6.385862, 1, -0.5, 0.5, 0.5,
	    2, -3.706006, -6.385862, 1, 1.5, 0.5, 0.5,
	    2, -3.706006, -6.385862, 0, 1.5, 0.5, 0.5,
	    3, -3.706006, -6.385862, 0, -0.5, 0.5, 0.5,
	    3, -3.706006, -6.385862, 1, -0.5, 0.5, 0.5,
	    3, -3.706006, -6.385862, 1, 1.5, 0.5, 0.5,
	    3, -3.706006, -6.385862, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<7; i++) 
                  for (var j=0; j<4; j++) {
                  ind = 7*(4*i + j) + 3;
                  v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
                  v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
                  v[ind] *= texinfo.widths[i]/texinfo.canvasX;
                  v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
                  - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
                  }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15,
	    16, 17, 18, 16, 18, 19,
	    20, 21, 22, 20, 22, 23,
	    24, 25, 26, 24, 26, 27
	   ]);
	   var buf12 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf12);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf12 = gl.createBuffer();
                  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf12);
                  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc12 = gl.getUniformLocation(prog12,"mvMatrix");
                  var prMatLoc12 = gl.getUniformLocation(prog12,"prMatrix");
      // ****** lines object 13 ******
	   var prog13  = gl.createProgram();
        gl.attachShader(prog13, this.getShader( gl, "bivarvshader13" ));
        gl.attachShader(prog13, this.getShader( gl, "bivarfshader13" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog13, 0, "aPos");
        gl.bindAttribLocation(prog13, 1, "aCol");
        gl.linkProgram(prog13);
	   var v=new Float32Array([
	    -3.419039, -3, -5.529199,
	    -3.419039, 3, -5.529199,
	    -3.419039, -3, -5.529199,
	    -3.589664, -3, -5.814753,
	    -3.419039, -2, -5.529199,
	    -3.589664, -2, -5.814753,
	    -3.419039, -1, -5.529199,
	    -3.589664, -1, -5.814753,
	    -3.419039, 0, -5.529199,
	    -3.589664, 0, -5.814753,
	    -3.419039, 1, -5.529199,
	    -3.589664, 1, -5.814753,
	    -3.419039, 2, -5.529199,
	    -3.589664, 2, -5.814753,
	    -3.419039, 3, -5.529199,
	    -3.589664, 3, -5.814753
	   ]);
	   var buf13 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf13);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc13 = gl.getUniformLocation(prog13,"mvMatrix");
                  var prMatLoc13 = gl.getUniformLocation(prog13,"prMatrix");
      // ****** text object 14 ******
	   var prog14  = gl.createProgram();
        gl.attachShader(prog14, this.getShader( gl, "bivarvshader14" ));
        gl.attachShader(prog14, this.getShader( gl, "bivarfshader14" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog14, 0, "aPos");
        gl.bindAttribLocation(prog14, 1, "aCol");
        gl.linkProgram(prog14);
	   var texts = [
	    "-3",
	    "-2",
	    "-1",
	    "0",
	    "1",
	    "2",
	    "3"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
                    var canvasX14 = texinfo.canvasX;
                    var canvasY14 = texinfo.canvasY;
	   var ofsLoc14 = gl.getAttribLocation(prog14, "aOfs");
	   var texture14 = gl.createTexture();
      var texLoc14 = gl.getAttribLocation(prog14, "aTexcoord");
      var sampler14 = gl.getUniformLocation(prog14,"uSampler");
    	   handleLoadedTexture(texture14, document.getElementById("bivartextureCanvas"));
	   var v=new Float32Array([
	    -3.930913, -3, -6.385862, 0, -0.5, 0.5, 0.5,
	    -3.930913, -3, -6.385862, 1, -0.5, 0.5, 0.5,
	    -3.930913, -3, -6.385862, 1, 1.5, 0.5, 0.5,
	    -3.930913, -3, -6.385862, 0, 1.5, 0.5, 0.5,
	    -3.930913, -2, -6.385862, 0, -0.5, 0.5, 0.5,
	    -3.930913, -2, -6.385862, 1, -0.5, 0.5, 0.5,
	    -3.930913, -2, -6.385862, 1, 1.5, 0.5, 0.5,
	    -3.930913, -2, -6.385862, 0, 1.5, 0.5, 0.5,
	    -3.930913, -1, -6.385862, 0, -0.5, 0.5, 0.5,
	    -3.930913, -1, -6.385862, 1, -0.5, 0.5, 0.5,
	    -3.930913, -1, -6.385862, 1, 1.5, 0.5, 0.5,
	    -3.930913, -1, -6.385862, 0, 1.5, 0.5, 0.5,
	    -3.930913, 0, -6.385862, 0, -0.5, 0.5, 0.5,
	    -3.930913, 0, -6.385862, 1, -0.5, 0.5, 0.5,
	    -3.930913, 0, -6.385862, 1, 1.5, 0.5, 0.5,
	    -3.930913, 0, -6.385862, 0, 1.5, 0.5, 0.5,
	    -3.930913, 1, -6.385862, 0, -0.5, 0.5, 0.5,
	    -3.930913, 1, -6.385862, 1, -0.5, 0.5, 0.5,
	    -3.930913, 1, -6.385862, 1, 1.5, 0.5, 0.5,
	    -3.930913, 1, -6.385862, 0, 1.5, 0.5, 0.5,
	    -3.930913, 2, -6.385862, 0, -0.5, 0.5, 0.5,
	    -3.930913, 2, -6.385862, 1, -0.5, 0.5, 0.5,
	    -3.930913, 2, -6.385862, 1, 1.5, 0.5, 0.5,
	    -3.930913, 2, -6.385862, 0, 1.5, 0.5, 0.5,
	    -3.930913, 3, -6.385862, 0, -0.5, 0.5, 0.5,
	    -3.930913, 3, -6.385862, 1, -0.5, 0.5, 0.5,
	    -3.930913, 3, -6.385862, 1, 1.5, 0.5, 0.5,
	    -3.930913, 3, -6.385862, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<7; i++) 
                  for (var j=0; j<4; j++) {
                  ind = 7*(4*i + j) + 3;
                  v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
                  v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
                  v[ind] *= texinfo.widths[i]/texinfo.canvasX;
                  v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
                  - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
                  }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15,
	    16, 17, 18, 16, 18, 19,
	    20, 21, 22, 20, 22, 23,
	    24, 25, 26, 24, 26, 27
	   ]);
	   var buf14 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf14);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf14 = gl.createBuffer();
                  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf14);
                  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc14 = gl.getUniformLocation(prog14,"mvMatrix");
                  var prMatLoc14 = gl.getUniformLocation(prog14,"prMatrix");
      // ****** lines object 15 ******
	   var prog15  = gl.createProgram();
        gl.attachShader(prog15, this.getShader( gl, "bivarvshader15" ));
        gl.attachShader(prog15, this.getShader( gl, "bivarfshader15" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog15, 0, "aPos");
        gl.bindAttribLocation(prog15, 1, "aCol");
        gl.linkProgram(prog15);
	   var v=new Float32Array([
	    -3.419039, -3.181283, -4,
	    -3.419039, -3.181283, 4,
	    -3.419039, -3.181283, -4,
	    -3.589664, -3.356191, -4,
	    -3.419039, -3.181283, -2,
	    -3.589664, -3.356191, -2,
	    -3.419039, -3.181283, 0,
	    -3.589664, -3.356191, 0,
	    -3.419039, -3.181283, 2,
	    -3.589664, -3.356191, 2,
	    -3.419039, -3.181283, 4,
	    -3.589664, -3.356191, 4
	   ]);
	   var buf15 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf15);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc15 = gl.getUniformLocation(prog15,"mvMatrix");
                  var prMatLoc15 = gl.getUniformLocation(prog15,"prMatrix");
      // ****** text object 16 ******
	   var prog16  = gl.createProgram();
        gl.attachShader(prog16, this.getShader( gl, "bivarvshader16" ));
        gl.attachShader(prog16, this.getShader( gl, "bivarfshader16" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog16, 0, "aPos");
        gl.bindAttribLocation(prog16, 1, "aCol");
        gl.linkProgram(prog16);
	   var texts = [
	    "-4",
	    "-2",
	    "0",
	    "2",
	    "4"
	   ];
	   var texinfo = drawTextToCanvas(texts, 1);	 
                    var canvasX16 = texinfo.canvasX;
                    var canvasY16 = texinfo.canvasY;
	   var ofsLoc16 = gl.getAttribLocation(prog16, "aOfs");
	   var texture16 = gl.createTexture();
      var texLoc16 = gl.getAttribLocation(prog16, "aTexcoord");
      var sampler16 = gl.getUniformLocation(prog16,"uSampler");
    	   handleLoadedTexture(texture16, document.getElementById("bivartextureCanvas"));
	   var v=new Float32Array([
	    -3.930913, -3.706006, -4, 0, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, -4, 1, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, -4, 1, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, -4, 0, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, -2, 0, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, -2, 1, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, -2, 1, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, -2, 0, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, 0, 0, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, 0, 1, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, 0, 1, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, 0, 0, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, 2, 0, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, 2, 1, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, 2, 1, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, 2, 0, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, 4, 0, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, 4, 1, -0.5, 0.5, 0.5,
	    -3.930913, -3.706006, 4, 1, 1.5, 0.5, 0.5,
	    -3.930913, -3.706006, 4, 0, 1.5, 0.5, 0.5
	   ]);
	   for (var i=0; i<5; i++) 
                  for (var j=0; j<4; j++) {
                  ind = 7*(4*i + j) + 3;
                  v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i]/width;
                  v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight/height;
                  v[ind] *= texinfo.widths[i]/texinfo.canvasX;
                  v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
                  - v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
                  }
	   var f=new Uint16Array([
	    0, 1, 2, 0, 2, 3,
	    4, 5, 6, 4, 6, 7,
	    8, 9, 10, 8, 10, 11,
	    12, 13, 14, 12, 14, 15,
	    16, 17, 18, 16, 18, 19
	   ]);
	   var buf16 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf16);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var ibuf16 = gl.createBuffer();
                  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf16);
                  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
	   var mvMatLoc16 = gl.getUniformLocation(prog16,"mvMatrix");
                  var prMatLoc16 = gl.getUniformLocation(prog16,"prMatrix");
      // ****** lines object 17 ******
	   var prog17  = gl.createProgram();
        gl.attachShader(prog17, this.getShader( gl, "bivarvshader17" ));
        gl.attachShader(prog17, this.getShader( gl, "bivarfshader17" ));
        //  Force aPos to location 0, aCol to location 1 
        gl.bindAttribLocation(prog17, 0, "aPos");
        gl.bindAttribLocation(prog17, 1, "aCol");
        gl.linkProgram(prog17);
	   var v=new Float32Array([
	    -3.419039, -3.181283, -5.529199,
	    -3.419039, 3.815012, -5.529199,
	    -3.419039, -3.181283, 5.892978,
	    -3.419039, 3.815012, 5.892978,
	    -3.419039, -3.181283, -5.529199,
	    -3.419039, -3.181283, 5.892978,
	    -3.419039, 3.815012, -5.529199,
	    -3.419039, 3.815012, 5.892978,
	    -3.419039, -3.181283, -5.529199,
	    3.405939, -3.181283, -5.529199,
	    -3.419039, -3.181283, 5.892978,
	    3.405939, -3.181283, 5.892978,
	    -3.419039, 3.815012, -5.529199,
	    3.405939, 3.815012, -5.529199,
	    -3.419039, 3.815012, 5.892978,
	    3.405939, 3.815012, 5.892978,
	    3.405939, -3.181283, -5.529199,
	    3.405939, 3.815012, -5.529199,
	    3.405939, -3.181283, 5.892978,
	    3.405939, 3.815012, 5.892978,
	    3.405939, -3.181283, -5.529199,
	    3.405939, -3.181283, 5.892978,
	    3.405939, 3.815012, -5.529199,
	    3.405939, 3.815012, 5.892978
	   ]);
	   var buf17 = gl.createBuffer();
                  gl.bindBuffer(gl.ARRAY_BUFFER, buf17);
                  gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
	   var mvMatLoc17 = gl.getUniformLocation(prog17,"mvMatrix");
                  var prMatLoc17 = gl.getUniformLocation(prog17,"prMatrix");
	   gl.enable(gl.DEPTH_TEST);
      gl.depthFunc(gl.LEQUAL);
      gl.clearDepth(1.0);
      gl.clearColor(1, 1, 1, 1);
      var xOffs = yOffs = 0,  drag  = 0;
      drawScene.call(this);
      function drawScene(){
      gl.depthMask(true);
      gl.disable(gl.BLEND);
	     var radius = 8.027393;
      var s = sin(this.fov*PI/360);
      var t = tan(this.fov*PI/360);
      var distance = radius/s;
      var near = distance - radius;
      var far = distance + radius;
      var hlen = t*near;
      var aspect = width/height;
      prMatrix.makeIdentity();
      if (aspect > 1)
      prMatrix.frustum(-hlen*aspect*this.zoom, hlen*aspect*this.zoom, 
      -hlen*this.zoom, hlen*this.zoom, near, far);
      else  
      prMatrix.frustum(-hlen*this.zoom, hlen*this.zoom, 
      -hlen*this.zoom/aspect, hlen*this.zoom/aspect, 
      near, far);
	     mvMatrix.makeIdentity();
      mvMatrix.translate( 0.006550431, -0.3168646, -0.1818898 );
      mvMatrix.scale( 1.271707, 1.240567, 0.7598704 );   
      mvMatrix.multRight( this.userMatrix );  
      mvMatrix.translate(0, 0, -distance);
	     gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
      // ****** points object 6 *******
	     gl.useProgram(prog6);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf6);
	     gl.uniformMatrix4fv( prMatLoc6, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc6, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.enableVertexAttribArray( colLoc );
                gl.vertexAttribPointer(colLoc, 4, gl.FLOAT, false, 28, 12);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawArrays(gl.POINTS, 0, 1000);
      // ****** text object 8 *******
	     gl.useProgram(prog8);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf8);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf8);
	     gl.uniformMatrix4fv( prMatLoc8, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc8, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc8 );
                gl.vertexAttribPointer(texLoc8, 2, gl.FLOAT, false, 28, 12);
                gl.activeTexture(gl.TEXTURE0);
                gl.bindTexture(gl.TEXTURE_2D, texture8);
                gl.uniform1i( sampler8, 0);
	     gl.enableVertexAttribArray( ofsLoc8 );
                gl.vertexAttribPointer(ofsLoc8, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
      // ****** text object 9 *******
	     gl.useProgram(prog9);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf9);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf9);
	     gl.uniformMatrix4fv( prMatLoc9, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc9, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc9 );
                gl.vertexAttribPointer(texLoc9, 2, gl.FLOAT, false, 28, 12);
                gl.activeTexture(gl.TEXTURE0);
                gl.bindTexture(gl.TEXTURE_2D, texture9);
                gl.uniform1i( sampler9, 0);
	     gl.enableVertexAttribArray( ofsLoc9 );
                gl.vertexAttribPointer(ofsLoc9, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
      // ****** text object 10 *******
	     gl.useProgram(prog10);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf10);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf10);
	     gl.uniformMatrix4fv( prMatLoc10, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc10, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc10 );
                gl.vertexAttribPointer(texLoc10, 2, gl.FLOAT, false, 28, 12);
                gl.activeTexture(gl.TEXTURE0);
                gl.bindTexture(gl.TEXTURE_2D, texture10);
                gl.uniform1i( sampler10, 0);
	     gl.enableVertexAttribArray( ofsLoc10 );
                gl.vertexAttribPointer(ofsLoc10, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
      // ****** lines object 11 *******
	     gl.useProgram(prog11);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf11);
	     gl.uniformMatrix4fv( prMatLoc11, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc11, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 16);
      // ****** text object 12 *******
	     gl.useProgram(prog12);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf12);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf12);
	     gl.uniformMatrix4fv( prMatLoc12, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc12, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc12 );
                gl.vertexAttribPointer(texLoc12, 2, gl.FLOAT, false, 28, 12);
                gl.activeTexture(gl.TEXTURE0);
                gl.bindTexture(gl.TEXTURE_2D, texture12);
                gl.uniform1i( sampler12, 0);
	     gl.enableVertexAttribArray( ofsLoc12 );
                gl.vertexAttribPointer(ofsLoc12, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 42, gl.UNSIGNED_SHORT, 0);
      // ****** lines object 13 *******
	     gl.useProgram(prog13);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf13);
	     gl.uniformMatrix4fv( prMatLoc13, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc13, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 16);
      // ****** text object 14 *******
	     gl.useProgram(prog14);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf14);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf14);
	     gl.uniformMatrix4fv( prMatLoc14, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc14, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc14 );
                gl.vertexAttribPointer(texLoc14, 2, gl.FLOAT, false, 28, 12);
                gl.activeTexture(gl.TEXTURE0);
                gl.bindTexture(gl.TEXTURE_2D, texture14);
                gl.uniform1i( sampler14, 0);
	     gl.enableVertexAttribArray( ofsLoc14 );
                gl.vertexAttribPointer(ofsLoc14, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 42, gl.UNSIGNED_SHORT, 0);
      // ****** lines object 15 *******
	     gl.useProgram(prog15);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf15);
	     gl.uniformMatrix4fv( prMatLoc15, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc15, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 12);
      // ****** text object 16 *******
	     gl.useProgram(prog16);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf16);
	     gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf16);
	     gl.uniformMatrix4fv( prMatLoc16, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc16, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.enableVertexAttribArray( texLoc16 );
                gl.vertexAttribPointer(texLoc16, 2, gl.FLOAT, false, 28, 12);
                gl.activeTexture(gl.TEXTURE0);
                gl.bindTexture(gl.TEXTURE_2D, texture16);
                gl.uniform1i( sampler16, 0);
	     gl.enableVertexAttribArray( ofsLoc16 );
                gl.vertexAttribPointer(ofsLoc16, 2, gl.FLOAT, false, 28, 20);
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
	     gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
      // ****** lines object 17 *******
	     gl.useProgram(prog17);
	     gl.bindBuffer(gl.ARRAY_BUFFER, buf17);
	     gl.uniformMatrix4fv( prMatLoc17, false, new Float32Array(prMatrix.getAsArray()) );
                        gl.uniformMatrix4fv( mvMatLoc17, false, new Float32Array(mvMatrix.getAsArray()) );
	     gl.enableVertexAttribArray( posLoc );
	     gl.disableVertexAttribArray( colLoc );
                gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
	     gl.lineWidth( 1 );
	     gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
	     gl.drawArrays(gl.LINES, 0, 24);
  gl.flush ();
      }
	   var vlen = function(v) {
    return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2])
  }
    var xprod = function(a, b) {
    return [a[1]*b[2] - a[2]*b[1],
    a[2]*b[0] - a[0]*b[2],
    a[0]*b[1] - a[1]*b[0]];
    }
    var screenToVector = function(x, y) {
    var radius = max(width, height)/2.0;
    var cx = width/2.0;
    var cy = height/2.0;
    var px = (x-cx)/radius;
    var py = (y-cy)/radius;
    var plen = sqrt(px*px+py*py);
    if (plen > 1.e-6) { 
    px = px/plen;
    py = py/plen;
    }
    var angle = (SQRT2 - plen)/SQRT2*PI/2;
    var z = sin(angle);
    var zlen = sqrt(1.0 - z*z);
    px = px * zlen;
    py = py * zlen;
    return [px, py, z];
    }
    var rotBase;
    var self = this;
	   var trackballdown = function(x,y) {
                                 rotBase = screenToVector(x, y);
                                 saveMat.load(self.userMatrix);
    }
                                 var trackballmove = function(x,y) {
                                 var rotCurrent = screenToVector(x,y);
                                 var dot = rotBase[0]*rotCurrent[0] + 
                                 rotBase[1]*rotCurrent[1] + 
                                 rotBase[2]*rotCurrent[2];
                                 var angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180./PI;
                                 var axis = xprod(rotBase, rotCurrent);
                                 saveMat.rotate(angle, axis[0], axis[1], axis[2]);
                                 self.setUserMatrix(saveMat);	     
                                 drawScene.call(self);
                                 rotBase = screenToVector(x, y);
                                 }
	   var y0zoom = 0;
                                 var zoom0 = 1;
                                 var zoomdown = function(x, y) {
                                 y0zoom = y;
                                 zoom0 = log(self.zoom);
                                 }
                                 var zoommove = function(x, y) {
                                 self.setZoom(exp(zoom0 + (y-y0zoom)/height));
                                 drawScene.call(self);
                                 }
	   var y0fov = 0;
                                 var fov0 = 1;
                                 var fovdown = function(x, y) {
                                 y0fov = y;
                                 fov0 = self.fov;
                                 }
                                 var fovmove = function(x, y) {
                                 self.setFOV(max(1, min(179, fov0 + 180*(y-y0fov)/height)));
                                 drawScene.call(self);
                                 }
	   var mousedown = [trackballdown, zoomdown, fovdown];
      var mousemove = [trackballmove, zoommove, fovmove];
	   function relMouseCoords(event){
    var totalOffsetX = 0;
    var totalOffsetY = 0;
    var currentElement = canvas;
    do{
    totalOffsetX += currentElement.offsetLeft;
    totalOffsetY += currentElement.offsetTop;
    }
    while(currentElement = currentElement.offsetParent)
    var canvasX = event.pageX - totalOffsetX;
    var canvasY = event.pageY - totalOffsetY;
    return {x:canvasX, y:canvasY}
                }
    canvas.onmousedown = function ( ev ){
    if (!ev.which) // Use w3c defns in preference to MS
    switch (ev.button) {
    case 0: ev.which = 1; break;
    case 1: 
    case 4: ev.which = 2; break;
    case 2: ev.which = 3;
    }
    drag = ev.which;
    var f = mousedown[drag-1];
    if (f) {
    var coords = relMouseCoords(ev);
    f(coords.x, height-coords.y); 
    ev.preventDefault();
    }
    }    
    canvas.onmouseup = function ( ev ){	
    drag = 0;
    }
    canvas.onmouseout = canvas.onmouseup;
    canvas.onmousemove = function ( ev ){
    if ( drag == 0 ) return;
    var f = mousemove[drag-1];
    if (f) {
    var coords = relMouseCoords(ev);
    f(coords.x, height-coords.y);
    }
    }
    var wheelHandler = function(ev) {
    var del = 1.1;
    if (ev.shiftKey) del = 1.01;
    var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
    self.setZoom(self.zoom * ds);
    drawScene.call(self);
    ev.preventDefault();
    };
    canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
    canvas.addEventListener("mousewheel", wheelHandler, false);
    };
    this.setZoom = function(zoom){
    this.zoom = zoom;
    for (var i = 0; i < this.zoomCallbacks.length; i++){
    this.zoomCallbacks[i](zoom);
    }
    };
    this.setUserMatrix = function(mat){
    this.userMatrix.load(mat);
    for (var i = 0; i < this.panCallbacks.length; i++){
    this.panCallbacks[i](this.userMatrix);
    }
    };
    this.setFOV = function(fov){
    this.fov = fov;
    for (var i = 0; i < this.fovCallbacks.length; i++){
    this.fovCallbacks[i](this.fov);
    }
    }
    this.getZoom = function(){
    return this.zoom;
    };
    this.getFOV = function(){
    return this.fov;
    }
    this.getUserMatrix = function(){
    return this.userMatrix;
    };
    this.onPan = function(callback){
    this.panCallbacks.push(callback);
    };
    this.onZoom = function(callback){
    this.zoomCallbacks.push(callback);
    };
    this.onFOV = function(callback){
    this.fovCallbacks.push(callback);
    }
    }).call(bivarWebGLClass.prototype);
    bivarWebGL = new bivarWebGLClass();
</script>
<canvas id="bivarcanvas" width="1" height="1"></canvas> 
<p id="bivardebug">
<img src="bivarsnapshot.png" alt="bivarsnapshot" width=505/><br>
                             You must enable Javascript to view this page properly.</p>
<script>bivarwebGLStart();</script>


