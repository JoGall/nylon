# Nylon image analysis
Quantifies encapsulation, melanisation and length of nylon monofilaments used in immunological assays.

### Requirements and compilation

The script requires an installation of the Open Source Computer Vision library, [OpenCV](http://opencv.org/quickstart.html.). The script then needs to be compiled; for example, using the GNU C++ compiler on Linux:

```g ++ -ggdb -o ./nylon ./nylonAnalysis.cpp `pkg-config --cflags opencv` `pkg-config --libs opencv` ```


### General use
Visually defining the degree of nylon encapsulation is a subjective process, as the user must decide what is areas of the image are sufficiently dark enough to constitute cellular encapsulation. The script therefore requires a brightness threshold to be defined, and the number of pixels in the main contour (the nylon monofilament) below this threshold is counted. Foreground extraction works best when images of the nylon are captured against a lighter, contrasting background.

### Command line usage:

```./PROGRAM_NAME lower_threshold upper_threshold FILE_1 FILE_2 ..```

Where `lower_threshold` equals the desired lower brightness threshold and `upper_threshold` the desired higher threshold **+1**.


#####Examples
When compiled with the program name 'nylon', as above. To define one brightness threshold (99) for all .jpg images in current directory:

```./nylon 99 100 *.jpg```

To define a brightness threshold range (90-110) for two images, 'test1.jpg' and 'test2.jpg'.

```./nylon 90 111 test1.jpg test2.jpg```

Note that by default, image mask files are only outputted when **one** brightness threshold is defined.


### Calibration
In order to calibrate the assay, an appropriate brightness threshold must be used to define encapsulation. This could be approximated by eye, testing different thresholds and viewing the resultant image mask to find a good estimate. However, for a more rigorous calibration, we can iterate the script over all brightness thresholds (0-255) for a few images, and compare this with manually-calculated scores for the same images to find the automated threshold with the closest match.

Automation of the script over all brightness thresholds can be achieved by, for example:

```./nylon 0 256 *.jpg```

For manual scoring of encapsulation, the open source image analysis software [ImageJ](http://imagej.nih.gov/ij/) is a useful tool. Briefly, we can convert images to greyscale (`Image > Type > 8-bit`), brightness threshold appropriately (`Image > Adjust > Threshold`), and measure the resultant number of pixels under the threshold (`Analyze > Measure`). For images with background noise, the `Polygon selection` or `Freehand selection` tools can be used to extract the desired foreground and give a more accurate measurement.

Sample images and an example R script, "calibrateThreshold.R", are provided at  [`nylon/calibration_example/`](https://github.com/JoGall/nylon-encapsulation/tree/master/calibration_example).
