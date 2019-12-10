import matplotlib.pyplot as plt
import cv2
import numpy as np
import random
import os
import skimage.io as io
os.environ["CUDA_DEVICE_ORDER"]="PCI_BUS_ID";
os.environ["CUDA_VISIBLE_DEVICES"] = "0"

import tensorflow as tf
from keras import backend as K

import keras
from segmentation_models import Unet,FPN
from segmentation_models.backbones import get_preprocessing
from segmentation_models.losses import bce_jaccard_loss,dice_loss
from segmentation_models.metrics import f_score,iou_score
from segmentation_models.utils import set_trainable
from keras.layers import Input, Conv2D
from keras.models import Model
from keras.models import *
from keras.optimizers import *
from keras.callbacks import ModelCheckpoint, LearningRateScheduler
from sklearn.utils import shuffle
import time

def adjustData(img,mask):
    mask = mask /255
    mask[mask > 0.5] = 1
    mask[mask <= 0.5] = 0
    img = img.reshape(512,512,1)
    mask = mask.reshape(512,512,1)
    return (img,mask)

def generator(path,pathMask,samples,batch_size,preprocess_input):
    target_size = (512,512)
    num_samples = len(samples)
    while 1:
        for offset in range(0, num_samples, batch_size):
            batch_samples = samples[offset:offset+batch_size]
            x_train = []    
            mask_train = []
            for i in batch_samples:
                x = cv2.imread(os.path.join(path,i),0)
                m1 = i.split('.')
                m = m1[0] + '_color.png'
                mask = cv2.imread(os.path.join(pathMask,m),0)
                #print(os.path.join(path,i))
                #print(os.path.join(pathMask,m))

                x = cv2.resize(x, target_size)
                mask = cv2.resize(mask, target_size)

                x,mask = adjustData(x,mask)

                x.astype('uint8')
                x = preprocess_input(x)
                mask = mask.astype('uint8')                
                x_train.append(x)
                mask_train.append(mask)
            X_train = np.array(x_train)
            Y_train = np.array(mask_train)
            #print(X_train.shape)
            yield shuffle(X_train, Y_train)
                   
  
path =  "/home/jaswanth/train/train/"
pathMask = "/home/jaswanth/train/color/"
filenames = os.listdir(path)
random.shuffle(filenames)
print(len(filenames))
batchsize = 1
samples = filenames[:3]
validate = filenames[3:]
BACKBONE = 'inceptionv3'
preprocess_input = get_preprocessing(BACKBONE)

train_generator = generator(path,pathMask,samples,batchsize,preprocess_input)
validate_generator = generator(path,pathMask,validate,batchsize,preprocess_input)
print("No. of training samples : "+str(len(samples)))
print("No. of validation samples : "+str(len(validate)))
print("starting")

# define model
model = FPN(backbone_name=BACKBONE, encoder_weights=None, input_shape=(None, None,1),  classes=1, activation='sigmoid')
model_checkpoint = ModelCheckpoint('checkpoint/unet_6000v16_membrane.hdf5', monitor='loss',verbose=1, save_best_only=True)
model.compile('Adam', loss=bce_jaccard_loss, metrics=[iou_score])
print('Created and loaded model')
model.summary()

# fit model
history = model.fit_generator(
    train_generator,
    epochs=10,
    validation_data = validate_generator,
    steps_per_epoch = np.ceil(len(samples) / batchsize),
    validation_steps = np.ceil(len(validate) / batchsize),
    callbacks=[model_checkpoint]
)
plt.plot(history.history['iou_score'])
plt.plot(history.history['val_iou_score'])
plt.title('Model iou_score')
plt.ylabel('iou_score')
plt.xlabel('Epoch')
plt.legend(['Train','Validation'], loc='upper left')
plt.show()

plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('Model loss')
plt.ylabel('Loss')
plt.xlabel('Epoch')
plt.legend(['Train','Validation'], loc='upper left')
plt.show()
