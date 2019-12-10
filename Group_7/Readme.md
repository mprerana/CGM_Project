# Activity Recognition using Multi-modality

##### Programming Language Used : Python

##### Dataset Uses: Charades Dataset	(http://ai2-website.s3.amazonaws.com/data/Charades_v1_rgb.tarR)

##### Dependencies:
###### 	i)Module Dependencies
 		* pandas
 		* glob
 		* os
 		* matplotlib
 		* PIL
 		* numpy
 		* math
 		* tensorflow
 		* nltk

##### Instructions
 	i)Download the charades dataset into the same directory as the code.
  
 	ii)Create a new conda enviornment (Refer https://uoa-eresearch.github.io/eresearch-cookbook/recipe/2014/11/20/conda/)
  
 	iii)Install all the module dependencies to this newly created enviornment
  
 	iv)Install jupyter notebook locally (Refer https://jupyter.readthedocs.io/en/latest/install.html)
  
 	iv)Run jupyter notebook locally (Refer https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/execute.html)
  
 	v)Run the file 'frameextractor.ipynb' using jupyter notebook first, which would generate the file 'img_ebd.npy'. This would process and extract the respective frames from the dataset and store it into the file 'img_ebd.npy'.
  
 	vi)Now Run the file 'CGM.ipynb' using jupyter notebook. This can be used to train the model ans test it as well.
