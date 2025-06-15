# RotaryMenuExperiment

This is an experiment to see how well (and how aesthetically) the glass effect combines with a "rotary menu".

To make this production-ready, the main changes would be:

- [ ] have the layout calculate most of its parameters (e.g. derive most radii from item sizes and required inter-item spacing, etc.)
- [ ] give more-explicit control over item positions (e.g. easier to pin a particular item to a particular spot / direction, and have the layout adjust as-needed)
- [ ] make item position animatable

At present, though, the glass effect appears to be glitchy:

- sometimes it works perfectly
- other times it gets into a state where the glass effect gets "lost" during animations
- sometimes it stays in that glitchy state indefinitely
- other times it will "snap out of it" after awhile

Particularly curious is that the glitchy state will often become un-glitchy if you quit and relaunch the demo app.

As such, this experiment is put on pause for now; will revisit it once we're a few more betas into the season.
