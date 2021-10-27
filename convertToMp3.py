import moviepy.editor as mp
import os
from os import listdir
from os.path import isfile, join
from colorama import Fore, Back, Style

onlyfiles = [f for f in listdir(os.getcwd()) if isfile(join(os.getcwd(), f))]
print("*** Choose a video file to convert to audio: ***")
for i in onlyfiles:
    print(str(onlyfiles.index(i) + 1) + ": " + i)

video_name_with_extension = ""
video_name = ""

while True:
    try:
        desire = int(input(": "))
        video_name_with_extension = onlyfiles[desire-1]
        video_name = video_name_with_extension.rsplit(".", 1)[0]
        video = mp.VideoFileClip(video_name_with_extension)
        video.audio.write_audiofile(video_name + ".mp3")

    except Exception:
        print("\n" + Fore.RED + Back.GREEN +
              "!!! Please enter the appropriate number value of VIDEO: " + Style.RESET_ALL)
        print(Fore.CYAN + "!NOTE: support any type of video file format: .mp4 (mpeg-4), .mkv, .avi, .mov..." + Style.RESET_ALL)
        for i in onlyfiles:
            print(str(onlyfiles.index(i) + 1) + ": " + i)
        continue
    else:
        break
print("\nConverted:\n"+video_name_with_extension+"\nto\n"+video_name+".mp3")
