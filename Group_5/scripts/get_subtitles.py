from youtube_transcript_api import YouTubeTranscriptApi
import json
import os

def get_subtitles(video_id,target_folder):
	subtitles = YouTubeTranscriptApi.get_transcript(video_id,languages=["en"])
	file=os.path.join(target_folder,"subtitles.json")
	with open(file,"w") as f:
		json.dump(subtitles,f)
	return file


# video_id = input("enter the youtube video ID:- ")

# subtitles = YouTubeTranscriptApi.get_transcript(video_id,languages=["en"])
# print(subtitles)

# with open("subtitles.json","w") as f:
# 	json.dump(subtitles,f)