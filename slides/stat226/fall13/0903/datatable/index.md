# Markdown example with knitr and googleVis
===========================================
This is a little Markdown example file.
Set the googleVis options first.
In this case change the behaviour of plot.gvis

```r
library(googleVis)
op <- options(gvis.plot.tag = "chart")
```

The following plot statements will automatically return  the HTML
required for the 'knitted' output. 

## Combo chart

```r
## Add the mean
CityPopularity$Mean=mean(CityPopularity$Popularity)
CC <- gvisComboChart(CityPopularity, xvar='City',
          yvar=c('Mean', 'Popularity'),
          options=list(seriesType='bars',
                       width=450, height=300,
                       title='City Popularity',
                       series='{0: {type:\"line\"}}'))
plot(CC)
```

<!-- ComboChart generated in R 3.0.0 by googleVis 0.4.4 package -->
<!-- Thu Aug 29 21:50:28 2013 -->


  <!-- jsHeader -->
  <script type="text/javascript">
   
  // jsData 
  function gvisDataComboChartID45f3d3d1b19 () {
  var data = new google.visualization.DataTable();
  var datajson =
  [
 [
 "New York",
450,
200 
],
[
 "Boston",
450,
300 
],
[
 "Miami",
450,
400 
],
[
 "Chicago",
450,
500 
],
[
 "Los Angeles",
450,
600 
],
[
 "Houston",
450,
700 
] 
];
  data.addColumn('string','City');
data.addColumn('number','Mean');
data.addColumn('number','Popularity');
  data.addRows(datajson);
  return(data);
  }
   
  // jsDrawChart
  function drawChartComboChartID45f3d3d1b19() {
  var data = gvisDataComboChartID45f3d3d1b19();
  var options = {};
  options["allowHtml"] = true;
options["seriesType"] = "bars";
options["width"] =    450;
options["height"] =    300;
options["title"] = "City Popularity";
options["series"] = {0: {type:"line"}};
  
  
    var chart = new google.visualization.ComboChart(
    document.getElementById('ComboChartID45f3d3d1b19')
    );
    chart.draw(data,options);
    
  
  }
    
   
  // jsDisplayChart
  (function() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  var chartid = "corechart";
  
  // Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
  var i, newPackage = true;
  for (i = 0; newPackage && i < pkgs.length; i++) {
  if (pkgs[i] === chartid)
  newPackage = false;
  }
  if (newPackage)
  pkgs.push(chartid);
  
  // Add the drawChart function to the global list of callbacks
  callbacks.push(drawChartComboChartID45f3d3d1b19);
  })();
  function displayChartComboChartID45f3d3d1b19() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
  }
  while (callbacks.length > 0)
  callbacks.shift()();
  } });
  }, 100);
  }
   
  // jsFooter
  </script>
   
  <!-- jsChart -->  
  <script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartComboChartID45f3d3d1b19"></script>
   
  <!-- divChart -->
    
  <div id="ComboChartID45f3d3d1b19"
  style="width: 450px; height: 300px;">
  </div>
  

Example of gvisComboChart with R code shown above.

## Place two charts next to each other
<!-- GeoChart generated in R 3.0.0 by googleVis 0.4.4 package -->
<!-- Thu Aug 29 21:50:28 2013 -->


  <!-- jsHeader -->
  <script type="text/javascript">
   
  // jsData 
  function gvisDataGeoChartID45f76be25b7 () {
  var data = new google.visualization.DataTable();
  var datajson =
  [
 [
 "Germany",
3 
],
[
 "Brazil",
4 
],
[
 "United States",
5 
],
[
 "France",
4 
],
[
 "Hungary",
3 
],
[
 "India",
2 
],
[
 "Iceland",
1 
],
[
 "Norway",
4 
],
[
 "Spain",
5 
],
[
 "Turkey",
1 
] 
];
  data.addColumn('string','Country');
data.addColumn('number','Profit');
  data.addRows(datajson);
  return(data);
  }
  

  // jsData 
  function gvisDataTableID45f3d9e4e48 () {
  var data = new google.visualization.DataTable();
  var datajson =
  [
 [
 "Germany",
3,
true 
],
[
 "Brazil",
4,
false 
],
[
 "United States",
5,
true 
],
[
 "France",
4,
true 
],
[
 "Hungary",
3,
false 
],
[
 "India",
2,
true 
],
[
 "Iceland",
1,
false 
],
[
 "Norway",
4,
true 
],
[
 "Spain",
5,
true 
],
[
 "Turkey",
1,
false 
] 
];
  data.addColumn('string','Country');
data.addColumn('number','Profit');
data.addColumn('boolean','Online');
  data.addRows(datajson);
  return(data);
  }
   
  // jsDrawChart
  function drawChartGeoChartID45f76be25b7() {
  var data = gvisDataGeoChartID45f76be25b7();
  var options = {};
  options["width"] =    350;
options["height"] =    300;
  
  
    var chart = new google.visualization.GeoChart(
    document.getElementById('GeoChartID45f76be25b7')
    );
    chart.draw(data,options);
    
  
  }
    
  

  // jsDrawChart
  function drawChartTableID45f3d9e4e48() {
  var data = gvisDataTableID45f3d9e4e48();
  var options = {};
  options["allowHtml"] = true;
options["height"] =    300;
options["width"] =    200;
  
  
    var chart = new google.visualization.Table(
    document.getElementById('TableID45f3d9e4e48')
    );
    chart.draw(data,options);
    
  
  }
    
   
  // jsDisplayChart
  (function() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  var chartid = "geochart";
  
  // Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
  var i, newPackage = true;
  for (i = 0; newPackage && i < pkgs.length; i++) {
  if (pkgs[i] === chartid)
  newPackage = false;
  }
  if (newPackage)
  pkgs.push(chartid);
  
  // Add the drawChart function to the global list of callbacks
  callbacks.push(drawChartGeoChartID45f76be25b7);
  })();
  function displayChartGeoChartID45f76be25b7() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
  }
  while (callbacks.length > 0)
  callbacks.shift()();
  } });
  }, 100);
  }
  

  // jsDisplayChart
  (function() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  var chartid = "table";
  
  // Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
  var i, newPackage = true;
  for (i = 0; newPackage && i < pkgs.length; i++) {
  if (pkgs[i] === chartid)
  newPackage = false;
  }
  if (newPackage)
  pkgs.push(chartid);
  
  // Add the drawChart function to the global list of callbacks
  callbacks.push(drawChartTableID45f3d9e4e48);
  })();
  function displayChartTableID45f3d9e4e48() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
  }
  while (callbacks.length > 0)
  callbacks.shift()();
  } });
  }, 100);
  }
   
  // jsFooter
  </script>
   
  <!-- jsChart -->  
  <script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID45f76be25b7"></script>
  

  <!-- jsChart -->  
  <script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartTableID45f3d9e4e48"></script>
   
<table border="0">
<tr>
<td>

  <!-- divChart -->
    
  <div id="GeoChartID45f76be25b7"
  style="width: 350px; height: 300px;">
  </div>
  
</td>
<td>

  <!-- divChart -->
    
  <div id="TableID45f3d9e4e48"
  style="width: 200px; height: 300px;">
  </div>
  
</td>
</tr>
</table>

Example of a gvisGeoChart with gvisTable and R code hidden.

## Motion Chart

```r
M <- gvisMotionChart(Fruits, 'Fruit', 'Year',
         options=list(width=400, height=350))
plot(M)
```

<!-- MotionChart generated in R 3.0.0 by googleVis 0.4.4 package -->
<!-- Thu Aug 29 21:50:28 2013 -->


  <!-- jsHeader -->
  <script type="text/javascript">
   
  // jsData 
  function gvisDataMotionChartID45f580eec9b () {
  var data = new google.visualization.DataTable();
  var datajson =
  [
 [
 "Apples",
2008,
"West",
98,
78,
20,
"2008-12-31" 
],
[
 "Apples",
2009,
"West",
111,
79,
32,
"2009-12-31" 
],
[
 "Apples",
2010,
"West",
89,
76,
13,
"2010-12-31" 
],
[
 "Oranges",
2008,
"East",
96,
81,
15,
"2008-12-31" 
],
[
 "Bananas",
2008,
"East",
85,
76,
9,
"2008-12-31" 
],
[
 "Oranges",
2009,
"East",
93,
80,
13,
"2009-12-31" 
],
[
 "Bananas",
2009,
"East",
94,
78,
16,
"2009-12-31" 
],
[
 "Oranges",
2010,
"East",
98,
91,
7,
"2010-12-31" 
],
[
 "Bananas",
2010,
"East",
81,
71,
10,
"2010-12-31" 
] 
];
  data.addColumn('string','Fruit');
data.addColumn('number','Year');
data.addColumn('string','Location');
data.addColumn('number','Sales');
data.addColumn('number','Expenses');
data.addColumn('number','Profit');
data.addColumn('string','Date');
  data.addRows(datajson);
  return(data);
  }
   
  // jsDrawChart
  function drawChartMotionChartID45f580eec9b() {
  var data = gvisDataMotionChartID45f580eec9b();
  var options = {};
  options["width"] =    400;
options["height"] =    350;
  
  
    var chart = new google.visualization.MotionChart(
    document.getElementById('MotionChartID45f580eec9b')
    );
    chart.draw(data,options);
    
  
  }
    
   
  // jsDisplayChart
  (function() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  var chartid = "motionchart";
  
  // Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
  var i, newPackage = true;
  for (i = 0; newPackage && i < pkgs.length; i++) {
  if (pkgs[i] === chartid)
  newPackage = false;
  }
  if (newPackage)
  pkgs.push(chartid);
  
  // Add the drawChart function to the global list of callbacks
  callbacks.push(drawChartMotionChartID45f580eec9b);
  })();
  function displayChartMotionChartID45f580eec9b() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
  }
  while (callbacks.length > 0)
  callbacks.shift()();
  } });
  }, 100);
  }
   
  // jsFooter
  </script>
   
  <!-- jsChart -->  
  <script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartMotionChartID45f580eec9b"></script>
   
  <!-- divChart -->
    
  <div id="MotionChartID45f580eec9b"
  style="width: 400px; height: 350px;">
  </div>
  

Please note that the Motion Chart is only displayed when hosted on a
web server, or is placed in a directory which has been added to the 
trusted sources in the [security settings of Macromedia]
(http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html). 
See the googleVis package vignette for more details. 


```r
## Set options back to original options
options(op)
```

