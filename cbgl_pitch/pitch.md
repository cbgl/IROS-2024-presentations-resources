```
In 1998 legendary rapper DMX together with RnB icon Mary J. Blige in their song
"Coming from" famously asked: "If I don't know where I'm coming from, where
would I go?", thusly highlighting the importance of solving the global
localisation problem in mobile robotics before initiating any navigation
actions.
```

```
The current solutions to the problem of localising a robot without prior
knowledge of its whereabouts, also known as global localisation, fall into one
of two categories. In the first category belong methods which are robust
against noise and arbitrariness of environment but which require motion and
time. One the other hand those of the second category take minimal estimation
time but they make assumptions about the structure of the environment, they are
sensitive to noise, and demand preprocessing and tuning.  However, the problem
in the real world is that everything is uncertain, and WE want approaches which
work out of the box, with accurate results that can be repeated reliably.
```

```
That's where CBGL comes in. CBGL is a one-shot method that works with 2D LIDARs
in 2D maps, that makes the minimum number of assumptions possible: it only
requires the map and one sensor measurement. It does not require motion to
work, nor does it assume specific environmental structure or structures, or
even parameters to tune. CBGL's properties rest on the Cumulative Absolute
Error per Ray metric, which has minimal computational complexity, and whose
value scales with increasing position and orientational errors.
```

```
In real world experiments, in a typical environment of 180 meters squared,
using a real sensor, a noisy map, and over 6000 measurements, CBGL estimated
the sensor's position with an accuracy of less than fifty centimeters for
over 99 percent of the inputs, with an average execution time of less than
two seconds.
```

```
In experiments with synthetic data, where we deliberately decreased the maximum
radial range of the sensor AND its angular field of view, where we increased
its measurement noise, and placed it in environments with repeated room
structure, CBGL provided the lowest position and orientation errors, as well as
the highest number of poses with less than 50 centimeters of positional error
compared to other state-of-the-art Monte Carlo methods.
```

```
You can try CBGL today for free by downloading its Docker container and running
it on your robot. Thank you.
```
