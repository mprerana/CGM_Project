import cv2
import numpy as np
import face_recognition
# from google.colab.patches import cv2_imshow
from keras.models import model_from_json



def get(image_path):

    #Load Model
    json_file = open('../data/models/model.json', 'r')
    loaded_model_json = json_file.read()
    json_file.close()
    loaded_model = model_from_json(loaded_model_json)
    loaded_model.load_weights("../data/models/model.h5")


    #image
    path_image = image_path
    image = cv2.imread(path_image)
    # image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # image = cv2.resize(image, (48, 48))
    # image = np.reshape(image, (1, 48, 48, 1))
    # Initialize variables
    face_locations = []
    i=0
    # Find all the faces in the image
    face_locations = face_recognition.face_locations(image)
    if face_locations:
        top, right, bottom, left = face_locations[0]
        face_image = image[top:bottom, left:right]
        face_image = cv2.cvtColor(face_image, cv2.COLOR_BGR2GRAY)
        face_image = cv2.resize(face_image, (48, 48))
        face_image = np.reshape(face_image, (1, 48, 48, 1))
        predicted_score = np.max(loaded_model.predict(face_image))
        ans=loaded_model.predict(face_image)
        return ans[0][-1]
        # predicted_class=np.argmax(loaded_model.predict(face_image))
        # print("Score is: %.2f and class is %d" %(predicted_score, predicted_class))
        # (face_image)
    else:
        return None
        print("No face found yet")
      # Hit 'q' on the keyboard to quit!