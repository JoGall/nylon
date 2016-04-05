#Quantify encapsulation, melanisation and length of nylon monofilaments used in immunological assays.

### 1) Introduction
Visually defining the degree of nylon encapsulation is a subjective process, as the user must decide what is areas of the image are sufficiently dark enough to constitute cellular encapsulation. The script therefore requires a brightness threshold to be defined, and the number of pixels in the foreground (the nylon monofilament) below this threshold is counted. A solution for choosing an appropriate brightness threshold is offered below. Foreground extraction works best when images of the nylon are captured against a light and contrasting background.

### 2) Usage
#### a) Compilation
The script requires an installation of the Open Source Computer Vision library, [OpenCV](http://opencv.org/quickstart.html.). The script then needs to be compiled; for example, using the GNU C++ compiler on Linux:

```g ++ -ggdb -o ./nylon ./nylonAnalysis.cpp `pkg-config --cflags opencv` `pkg-config --libs opencv` ```

#### b) Command line use

```./nylon lower_threshold upper_threshold FILE_1 FILE_2 ..```

Where `lower_threshold` equals the desired lower brightness threshold and `upper_threshold` the desired higher threshold **+1**.

#### c) Examples
To define one brightness threshold (99) for all .jpg images in current directory:

```./nylon 99 100 *.jpg```

To define a brightness threshold range (90-110) for two images, 'test1.jpg' and 'test2.jpg'.

```./nylon 90 111 test1.jpg test2.jpg```

Note that by default, image mask files are only outputted when **one** brightness threshold is defined.

<img src="https://cloud.githubusercontent.com/assets/17113779/14283808/a7795506-fb3c-11e5-9665-bd9c47c9577f.jpg" width="250">
<img src="https://cloud.githubusercontent.com/assets/17113779/14283809/a79f62d2-fb3c-11e5-8088-11bf0af7ec12.jpg" width="250">
<img src="https://cloud.githubusercontent.com/assets/17113779/14283810/a79f93d8-fb3c-11e5-84a2-2a5baf1544e2.jpg" width="250">

**Figure 1**. Samples input and output images of nylon monofilaments following extraction from an insect. (Left) shows a raw input image, (centre) shows an output mask resulting from a relatively stringent encapsulation threshold (threshold = 70), and (right) shows an output mask from a relatively lenient threshold (threshold=110). In both image masks, grey areas show the identified foreground, in which mean pixel saturation is calculated to give the melanisation score. Black areas show pixels that are below the user-defined encapsulation threshold within the foreground area, which are enumerated to give the encapsulation score. The red line depicts the calculated length of the monofilament.


### 3) Calibration
In order to calibrate this assay, an appropriate brightness threshold must be used to define encapsulation. This could be approximated by eye, testing different thresholds and viewing the resultant image mask to find a good estimate. However, for a more rigorous calibration, we can iterate the script over all brightness thresholds (0-255) for a few images, and compare this with manually-calculated scores for the same images to find the automated threshold with the closest match.

Automation of the script over all brightness thresholds can be achieved by, for example:

```./nylon 0 256 *.jpg```

For manual scoring of encapsulation, the open source image analysis software [ImageJ](http://imagej.nih.gov/ij/) is a useful tool. Briefly, we can convert images to greyscale (`Image > Type > 8-bit`), brightness threshold appropriately (`Image > Adjust > Threshold`), and measure the resultant number of pixels under the threshold (`Analyze > Measure`). For images with background noise, the `Polygon selection` or `Freehand selection` tools can be used to extract the desired foreground and give a more accurate measurement.

Sample images and an example R script, "calibrateThreshold.R", are provided at  [`nylon/calibration_example/`](https://github.com/JoGall/nylon-encapsulation/tree/master/calibration_example).

<img src="https://cloud.githubusercontent.com/assets/17113779/14284097/f70101e0-fb3d-11e5-9615-ca47e8f1de38.png" width="500">

**Figure 2**. Sample calibration of user-defined thresholds used to define encapsulation score. Iteration of the automated image analysis script across a series of calibration images generated encapsulation scores for all possible brightness thresholds. Automated scores were then compared to manually calculated scores to find the closest matching brightness threshold, as shown by the red line.
