from cut_video import  merge_video
from download_video import download_video
from extracting_frames import extract_frames
from get_frame_subtitle import get_frame_subtitle
from get_subtitles import get_subtitles
from get_emotions import get_emotions, get_emotional_data_as_list
from get_least_neutral import get_least_neutral


def summarize(video_id, summary_length):
	# download video
	video_path = download_video(video_id,"../data/", "video")
	# video_path = "../data/video.mp4"
	print("Video Path=>", video_path)
	
	# get subtitles of the video
	subtitles_path = get_subtitles(video_id,"../data/")
	# subtitles_path = "../data/subtitles.json"
	print("Subtitles Path=>", subtitles_path)
	
	# extract frames from the video
	# frames_list, frames_folder = extract_frames(video_path, "../data/")
	frames_list = '../data/frames.csv'
	frames_folder = '../data/video_frames/'
	
	# get emotions of all the frames
	emotional_data = get_emotions(frames_list, "../data/")
	
	# sort the frames accoring to the emotions
	data_in_list = get_emotional_data_as_list(emotional_data)
	
	# get the length of the summary of the video
	# get details corresponding to the emotional frames
	# get_least_neutral()
	start,end = get_least_neutral(data_in_list, summary_length, subtitles_path)

	# cut the emotional frmaes
	# merge the emotional frames
	# save in the static folder
	path = merge_video(video_path,start,end,"../static/")
	
	# render the video in the web page
	