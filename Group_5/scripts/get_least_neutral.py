from get_frame_subtitle import get_frame_subtitle

def f(e):
	return e[-1]

def f2(e):
	return e["start"]

def get_least_neutral(data_in_list, summary_length, subtitles_file):
	data_in_list.sort(key=f)
	l=0
	ans=[]
	count=0
	
	while(l<summary_length):
		sub=get_frame_subtitle(float(data_in_list[count][-2]),'../data/subtitles.json')
		ans.append(sub)
		count+=1
		l+=sub["duration"]
	
	start,end=[],[]
	ans.sort(key=f2)

	for i in ans:
		start.append(i["start"])
		end.append(i["start"]+i["duration"])

	return start,end
