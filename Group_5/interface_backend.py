from flask import Flask, render_template, request, redirect, url_for
app = Flask(__name__)

@app.route("/", methods=['GET','POST'])
def home():
	data={"summarized":False}
	
	if(request.method=="POST"):
		video_id = request.form['video_id']	
		summary_length = request.form['summary_length']	
		
		print("got_{}".format(video_id))
		# data["video_path"]="./summary_video1.mp4"
		data["summarized"]=True
	
	return render_template("contact.html", data=data)
    
if __name__ == "__main__":
	app.run(debug=True)