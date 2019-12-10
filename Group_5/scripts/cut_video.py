from moviepy.video.io.ffmpeg_tools import ffmpeg_extract_subclip
from moviepy.editor import VideoFileClip, concatenate_videoclips

import os 

# def cut_video(video_path, start_time, end_time, target_path, i):
# 	final=target_path+"summary_video_{}.mp4".format(i)
# 	print(final)
# 	ffmpeg_extract_subclip(video_path, start_time, end_time, targetname=final)
# 	return final 
# 	# ffmpeg_extract_subclip("../../video1.mp4", 128.21, 128.21+2.404, targetname="./test.mp4")


def merge_video(video_file, start, end, target_path):
	final=os.path.join(target_path,"final.mp4")
	
	merger = []
	for i in range(len(start)):
		clip = VideoFileClip(video_file).subclip(start[i],end[i])
		merger.append(clip)	
	final_clip = concatenate_videoclips(merger)
	final_clip.write_videofile(final)
	
	return final