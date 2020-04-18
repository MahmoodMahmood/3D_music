My project is a dancing sphere that makes use of perlin noise, graphics shader pipelines, and blinn phong model to match the music.

The way it works is by having the light source rotate around the sphere in sync with the beat of the song and also by changing the procedurally generated bump height and bump frequency to match the waveform of the audio. This effectively creates a pretty cool "speaker" like response that matches the music pretty closely.

The way the python module interacts with the graphics pipelien is by editting the glsl files that render the sphere (primarily planet.fs and bump_height.glsl) everytime, this obviously isn't great because the program needs to recompile those glsl files each time but the dancing animation was quite smooth on my laptop so apparently it was not a bottleneck.

The project is of course heavily based on the assignment 6 codebase. Other sources used are python's PyAudio library for reading audio files and librosa for analyzing song bpm. It may be worth noting that I also spent a good 3 days tinkering with python's scikit FFT modules to get the waves just right but in the end I completely scrapped it because librosa did a much better job than me at tempo detection.

The one issue I had is that when I recorded the animation using Kazam, things did get a bit more choppy, I am not quite sure why that is but I couldn't make it better.

Overall, I am pretty happy with how it turned out and how it interacted with the music but I would have liked it to run a bit faster. I learned a lot about graphics pipelines, digital signal processing and music theory throughout the project and it was certainly a lot of fun to work on.
