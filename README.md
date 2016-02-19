An automated procedure to quantify encapsulation, melanisation and length of nylon monofilaments used in immunological assays

### Requirements and compilation

The script requires an installation of the Open Source Computer Vision library, [OpenCV](http://opencv.org/quickstart.html.). The script needs to be compiled. For example, using the GNU C++ compiler for Linux:

```g ++ -ggdb `pkg-config --cflags opencv` -o ./nylon ./nylonAnalysis.cpp `pkg-config --libs opencv````


### General use
Visually defining the degree of nylon encapsulation is a subjective process, as the user must decide what is areas of the image are sufficiently dark enough to constitute cellular encapsulation. The script therefore requires a brightness threshold to be defined, and the number of pixels in the main contour below this threshold counted.

### Command line usage:

```./PROGRAM_NAME lower_threshold upper_threshold FILE_1 FILE_2 ..```

Where `lower_threshold` equals the desired lower brightness threshold and `upper_threshold` the desired higher threshold **+1**.


#####Examples
When compiled as above, to iterate over all possible brightness thresholds (0-255) for all .jpg images in current directory:

```'./nylon 0 256 *.jpg'```


To define only one brightness threshold (99) for all .jpg images in current directory:

```./nylon 99 100 *.jpg```


### Calibration
In order to calibrate the assay and choose an appropriate threshold to define encapsulation, we can compare a few manually-calculated encapsulation scores with automatically-calculated encapsulation scores for the same images across all possible brightness thresholds, and find the automated brightness threshold which provides the closest match.

I assayed encapsulation manually using the thresholding tool in open source image analysis software, [ImageJ](http://imagej.nih.gov/ij/). The automated threshold iteratation can be performed for example by:

Sample images and an example R script, "calibrateThreshold.R", are provided in [`nylon/calibration_example/`](https://github.com/JoGall/nylon/tree/master/calibration_example).
