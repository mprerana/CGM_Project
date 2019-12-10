# this script getts the subtitle for the time of the frame given
import json
from bisect import bisect_left 


def get_frame_subtitle(frame_time, file):
	# frame_time=float(input())
	subtitle_list=None

	with open(file) as f:
		subtitle_list=json.load(f)

	if(subtitle_list==None):
		print("Not able to read the file privided")
	else:
		subtitle_time={}
		for i in subtitle_list:
			subtitle_time[i["start"]]=i

		start_time = list(subtitle_time.keys())

		start_time.sort()

		ans_time=bisect_left(start_time, frame_time)
		
		if(ans_time>=len(start_time) or ans_time==-1):
			print("Out of bound")
		else:
			return subtitle_time[start_time[ans_time]] 
			# print(subtitle_time[start_time[ans_time]])
