#!/usr/bin/env python3
"""
Module Docstring
"""

__author__ = "Your Name"
__version__ = "0.1.0"
__license__ = "MIT"

import os
import sys
import wave
import math
import time
import struct
import pyaudio
import librosa
import fileinput
import numpy as np

CHUNK = 1024  
VIZ_FILE = '/home/mahmood/CSC418/3D_music/src/planet.fs'
BUMP_HEIGHT = '/home/mahmood/CSC418/3D_music/src/bump_height.glsl'

def set_stripes(tempo):
    for line in fileinput.input(VIZ_FILE, inplace=True):
        if 'float stripex' in line:
            line = '  float stripex = 2*sin(normal_fs_in.x*perlin*'+ str(tempo/20) +'*M_PI)+1;\n'
        elif 'float stripey' in line:
            line = '  float stripey = 2*sin(normal_fs_in.x*perlin*' + str(tempo/80) + '*M_PI)+1;\n'
        sys.stdout.write(line)


def updateTheta(newTheta):
    for line in fileinput.input(VIZ_FILE, inplace=True):
        if 'float theta' in line:
            line = '  float theta = ' + str(newTheta) + ';\n'
        sys.stdout.write(line)
        
def colorChanger(time_to_next_beat):
    if (time_to_next_beat < 0.1):
        for line in fileinput.input(VIZ_FILE, inplace=True):
            if 'vec3 kd' in line:
                line = '  vec3 kd = vec3(1.5/r,0,'+ str((0.1-time_to_next_beat)) + ');\n'
            sys.stdout.write(line)   

def main(music_file):
    """ Main entry point of the app """
    y, sr = librosa.load(music_file)
    tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr)
    set_stripes(tempo)

    print('Estimated tempo: {:.2f} beats per minute'.format(tempo))
    beat_times = librosa.frames_to_time(beat_frames, sr=sr)

    f = wave.open(music_file, 'rb')

    p = pyaudio.PyAudio()  
    stream = p.open(format = p.get_format_from_width(f.getsampwidth()),  
                    channels = f.getnchannels(),  
                    rate = f.getframerate(),  
                    output = True) 

    data = f.readframes(CHUNK)
    start = time.time()
    beat_idx = 1
    while data:  
        stream.write(data, exception_on_underflow=False)  
        data = f.readframes(CHUNK)
        cur_time = time.time()-start
        
        if beat_idx < len(beat_times):
            updateTheta((cur_time - beat_times[beat_idx])/(beat_times[beat_idx]-beat_times[beat_idx-1])*2*math.pi)
         
            if cur_time > beat_times[beat_idx]:
                for i in range(10): 
                    if beat_idx % 2: 
                        print("#####################################") 
                    else: 
                        print("*************************************")
                print("time since last beat: {}".format(cur_time-beat_times[beat_idx-1]))
                beat_idx+=1
            else:
                colorChanger(beat_times[beat_idx] - cur_time);

    
    stream.stop_stream()  
    stream.close()  

    #close PyAudio  
    p.terminate()  

if __name__ == "__main__":
    """ This is executed when run from the command line """
    main(sys.argv[1])



















    #count = 0
    #freq_avg_arr = []
    #freq_var_arr = []

    #while data:  
        #data_int = struct.unpack(str(4*CHUNK) + 'B', data)
        #data_np = np.array(data_int, dtype='b')[::2] + 128
        ##data_np = np.array(data_int)
        #w = np.fft.fft(data_np)[1:]
        #freqs = np.fft.fftfreq(len(w))
        #idx = (np.abs(w)).argsort()[:10][::-1]
        #freq = np.array([freqs[i] for i in idx])
        #freq_in_hertz = abs(np.multiply(freq,f.getframerate()))
        #top_freqs_avg = sum(freq_in_hertz)/len(freq_in_hertz)
        #freq_avg_arr.append(top_freqs_avg)
        #top_freqs_var = np.var(freq_in_hertz)
        #freq_var_arr.append(top_freqs_var)
        #count+=1
        #if count % 20 == 0:
            #print(freq)
            #freq_avg_arr = []
            #freq_var_arr = []

        #stream.write(data)  
        #data = f.readframes(CHUNK)
 
