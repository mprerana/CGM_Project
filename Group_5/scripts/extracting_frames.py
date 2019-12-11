import cv2
import csv
import os


def extract_frames(video, target_folder_path):
    vidcap = cv2.VideoCapture(video)

    def format(value):
        return "%.3f" % value

    # if("data" not in os.listdir(".")):
    #     os.mkdir("data")
    if("video_frames" not in os.listdir(target_folder_path)):
        os.mkdir(os.path.join(target_folder_path,"video_frames"))
    else:
        os.system("rm "+os.path.join(target_folder_path,"video_frames")+"/*")


    def getFrame(sec,fr):
        vidcap.set(cv2.CAP_PROP_POS_MSEC,sec*1000)
        
        hasFrames,image = vidcap.read()
        if hasFrames:
            fr.append([str(count),"/video_frames/image"+str(count)+".jpg",format(sec)])
            cv2.imwrite(target_folder_path+"/video_frames/image"+str(count)+".jpg", image)     # save frame as JPG file
        return hasFrames,fr
    sec = 0.2
    frameRate = 1.0 #//it will capture image in each 0.5 second
    count=1
    fr = [["S.No","Image name","time"]]
    success,fr = getFrame(sec,fr)
    while success:
        count = count + 1
        sec = sec + frameRate
        sec = round(sec, 2)
        success,fr = getFrame(sec,fr)

    with open(target_folder_path+'/frames.csv', 'w') as file:
        writer = csv.writer(file)
        writer.writerows(fr)

    return target_folder_path+'/frames.csv',target_folder_path+"/video_frames/" 
    