```
1.
Hello everyone, I am Alexander and this is the presentation of CBGL, a fast monte carlo method for solving the global localisation problem with a 2D lidar sensor in a 2D map
```

```
2.
The gist of this presentation is that, if you have a 2d lidar placed in any environment, the environment's map, and a single sensor measurement, CBGL may estimate the position and orientation of the sensor in the map, without prior information, in roughly one second per 100 meters squared,
---
while at the same time being robust to varying maximum sensor ranges, its field of view, input noise, and repetitions of map portions.
```

```
3.
In the global localisation problem we want to estimate the 3DoF pose of a sensor in a map of the environment it is placed in without having any other information except for the map itself and measurements from the sensor.
---
You can imagine the problem as if you were a robot and you just opened up robotic Google Maps but without the satellites: you must first know what your location and orientation are in the space you are navigating in for any subsequent autonomous navigation to occur, and this is what makes solving this problem important.
```

```
4.
The global localisation problem is one of the three main localisation problems in mobile robotics, the other two being pose tracking, equivalent to Google maps tracking the pose of your cellphone as it moves, and the kidnapped robot problem.
```

```
5.
A solution to global localisation is necessary and crucial for robots relying on observer-based localisation methods, that is, methods that determine the pose of a robot only from measurements derived from on-board sensors. This concerns much of indoor situations, where GPS is denied, or where costly motion capture infrastructure cannot be utilised.
```

```here? or later on?
6.
The contributions of CBGL are:
one: that it solves the problem faster than any other monte carlo method. This is because it is based on the Cumulative Absolute Error per Ray metric, which is computable in O(N) time, where N is the number of rays of the lidar sensor
---
two: that is yields a higher discovery rate than state of the art methods that solve the same problem. But these two are just side-effects.
---
The piece de resistance is that CBGL extends from the pose tracking problem to the global localisation one, and validates that, given a dense-enough pose hypotheses set, the Cumulative Absolute Error per Ray metric is able to estimate pose estimate error hierarchies solely by using one lidar measurement and the map. This is important because while the pose error of a single pose hypothesis is fundamentally unknowable, if we disperse enough pose hypotheses over the map, calculate their CAER metric, and rank them by this value, the top of this hierarchy will include hypotheses in the neighbourhood of the sensor's pose.
```

```
7.
Before moving on to the details of CBGL we must first have to visit some concepts from the method's background.
```

```
8.
The first one is the concept of the map-scan. A map-scan is to the map of the environment exactly what a measurement from a lidar is to the environment itself. If you had a flawless sensor and a flawless map, a map-scan from an estimate of the sensor's pose with zero pose error would report the same ranges as the physical sensor's measurements.
```

``` optional at this point in the presentation
9.
The second one is the concept of scan–to–map-scan matching, or sm2. Just like scan-matching gives us the transform between two real range measurements, scan–to–map-scan matching gives us the transform between a map-scan and a real scan. This is important for localisation because if we have a pose estimate in a neighbourhood of the sensor, this transform essentially provides the pose of the physical sensor itself, which is what we seek after all.
```

```2d caer here, from fsm or x1 better yet
10.
The third concept is that of the Cumulative Absolute Error per Ray metric. The definition of the metric itself is very simple as you can see from this formula: we simply subtract the ranges of a virtual scan from those a real scan element-wise, take their absolute values, and sum them.
---
The power of the metric is revealed when we use it between one real scan SR and a multitude of virtual scans SV which have been captured within the map, from pose estimates in a neighbourhood of the sensor's pose. What is generally true in this case is that the CAER metric is proportional to a pose estimate's position error and also proportional to its orientation error, meaning that estimates closer to the sensor's pose report smaller CAER values than those farther away from it.
```

```
11.
We can exploit this fact for producing lidar odometry via plain scan-matching (left figure + citation), or for improving the pose estimate of localisation during pose tracking (right figure + citation)
```

```3d caer focused on the neighbourhood. sto we just have to nea diafaneia me ton CBGL se algorithm oste na boroume na anaferthoume se auton stin epomeni
12.
The question is what happens if we zoom out of that neighbourhood. If the same pattern holds for neighbourhoods of arbitrary radius then we may localise the sensor by dispersing a dense cloud of pose hypotheses on the map, calculate their CAER values, and pick the one that scores the minimum.
```

```3d caer entire
13.
In reality what happens is that, generally, outside of this neighbourhood the metric's values are larger than inside of it, and the metric is not disproportional to these estimate errors. These are still sufficient conditions for a solution resting on this metric to be able to localise a sensor accurately and in minimal time.
---
This is the motivation that led to the inception of the CAER-Based Global Localisation method, aka CBGL. CBGL first disperses a number of hypotheses on the map of the sensor's environment. This number is a function of the map's traversable area. Then, in algorithm 2, it computes the CAER value of each hypothesis and ranks them ascendingly. Subsequently it selects a number of the bottom-most hypotheses and it matches the virtual scans captured from them against the sensor's scan. This act helps obtain lower-error estimates, helps by diverging false positive estimates, and disengages the output from the input position and orientation density. In the end CBGL calculates the CAER values of the outputs of this process, and selects the one with the minimum value.
```

```
EXPERIMENTS
```

```
14.
In order to determine CBGL's performance and the limits of its reach we performed a number of tests.
```

``` left figure map + trajectory, right map errors
15.
The first type of test is an experiment in real conditions in the CSAL lab of the Aristotle University's Department of Electrical and Computer Engineering, with a hokuyo lidar of maximum range of 30 meters and an angular range of 270 degrees. In this figure you can see the trajectory that the sensor followed in the map, along which it captured over 6 thousand range measurements.
---
Each of these measurements we fed into CBGL, along with the map that you just saw, and 99.1 % of its outputs came out to have a location error less than half a meter, and more than 94% of them have orientation errors less than 4 degrees. The mean execution time in this environment, whose area is 180 squared meters was 1.6 seconds.
```

``` edo xalara, min anafertheis se alles methods, mono median vales gia errors + to synoliko rate gia ta outliers, oxi ana pose
16.
The next type of test was in simulation where we can construct any type of environment we want and with any sensor properties, in order to stress-test the method with regard to these variables. Here we consider a cheap sensor, meaning with considerable noise (0.05 m^2), and we limit the maximum range of the sensor to 10 meters. The first environment is a warehouse larger than 700 meters squared in area, with large empty spaces, where the method is tested against missing measurements and therefore increased ambiguities between pose hypotheses. The second environment is a large office complex around 2000 m^2 in area, whose purpose is to test the method against similar surroundings, and therefore give us an idea of the method's ability to make fine disctinctions between them.
---
We place the sensor in 16 challenging poses and call CBGL 100 times for each. As you can see in both cases the median position error was less than 15 cm, the orientation error less than 10 degrees, and 9 in ten outputs or more exhibited a position error less than half a meter, with the execution time being less than 10 seconds in both cases.
```

```
17.
The last type of test we conduct in order to get a sense of how different angular ranges and different scan–to–map-scan methods affect the output, and what the profile of the execution time is with respect to map area. The experimental procedure was conducted in over 45 thousand simulated environments, over two angular ranges, and four different sm2 methods, and show that (a) the core of CBGL, that is, CBGL minus the sm2 method is robust to varying angular range, and (b) that execution time is roughly 1 sec per 100 m^2 of area at one ray per degree.
```

```
LIMITATIONS
```

```
18.
Where CBGL fails to perform so well is when the sensor is situated in or very near door thresholds, or when the number of poses selected for matching is too small when the sensor is placed in ambiguous surroundings.
```

```
Thank you very much for your attention and for your time.
```
