from pytube import YouTube 
import os

def download_video(video_id, target_path, file_name):
	link="https://www.youtube.com/watch?v={}".format(video_id)   
	yt = YouTube(link)
	stream = yt.streams.filter(file_extension='mp4').first()
	stream.download(output_path=target_path, filename= file_name)
	return os.path.join(target_path,file_name+".mp4")
	# return the path of the downloaded video
