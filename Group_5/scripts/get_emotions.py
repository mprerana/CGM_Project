import random
import os
from emotional_value import get

def get_emotions(frame_list_path, target_path):
	
	f1=open(frame_list_path,"r")
	file=os.path.join(target_path,"emotions.csv")
	f2=open(file,"w")
	c=0
	for i in f1:
		# print(x)
		if(c==0):
			c+=1
			continue
		else:
			emoions=get("../data/"+i.split(",")[1])
			x=i.strip()+","+str(emoions)
			f2.write(x+"\n")
	f1.close()
	f2.close()
	return file

def get_emotional_data_as_list(file_path):
	l=[]
	with open(file_path) as f:
		for i in f:
			x=i.split(",")
			x[-1]=float(x[-1].strip())
			l.append(x)
	return l
