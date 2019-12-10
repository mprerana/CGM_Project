# Activity Recognition using Multi-modality

##### Group Members : Arvind Deshraj, G.Arshad, JUNAID N.Z, Rohan Sukumaran, Siddharth Kumar, Hareesh Devarkonda

##### Paper Link :

##### Medium Blog Link :

##### Introduction

The Charades dataset is composed of 9848 videos of indoor activities which were collected through the Amazon Mechanical Turk. The users were given a sentence and were asked to record a video acting out the sentence, resembling a game of Charades. Each video has been annotated using the consensus of 4 workers on the training set and 8 workers on the test set.


##### Programming Language Used : Python

##### Dataset Uses: Charades Dataset	(http://ai2-website.s3.amazonaws.com/data/Charades_v1_rgb.tarR)

##### Dependencies:
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
  
 	v)Run the file 'frameextractor.ipynb' using jupyter notebook first, which would generate the file 'img_ebd.npy'. 
    This would process and extract the respective frames from the dataset and store it into the file 'img_ebd.npy'.
  
 	vi)Now Run the file 'CGM.ipynb' using jupyter notebook. This can be used to train the model ans test it as well.

##### References
    1) C. Chiu, J. Zhan, F. Zhan, &quot;Uncovering suspicious activity from partially paired and
       incomplete multimodal data&quot;, IEEE Access, vol. 5, pp. 13689-13698, 2017.
    
    2) A. Shahroudy, T. T. Ng, Q. Yang, G. Wang, &quot;Multimodal multipart learning for action
       recognition in depth videos&quot;, IEEE Trans. Pattern Anal. Mach. Intell., vol. 38, no. 10,
       pp. 2123-2129, Oct. 2016.

    3) Fortin, Mathieu Pagé and Brahim Chaib-draa. “Multimodal Multitask Emotion
       Recognition using Images, Texts and Tags.” WCRML &#39;19 (2019).
    
    4) Shiqing Zhang, Shiliang Zhang, Tiejun Huang, and Wen Gao. 2016. Multimodal
       Deep Convolutional Neural Network for Audio-Visual Emotion Recognition. In
       Proceedings of the 2016 ACM on International Conference on Multimedia Retrieval
       (ICMR &#39;16). ACM, New York, NY, USA, 281-284.

     5) K. Chen, T. Bui, C. Fang, Z. Wang, and R. Nevatia. AMC: Attention guided multi-
        modal correlation learning for image search. In CVPR, 2017.

    6) Hori, C., Hori, T., Lee, T.Y., Zhang, Z., Harsham, B., Hershey, J.R., Marks, T.K.,
       Sumi, K.: Attention-based multimodal fusion for video description. In: 2017 IEEE
       International Conference on Computer Vision (ICCV).

    7) Ma, Haojie, Wenzhong Li, Xiao Zhang, Songcheng Gao, and Sanglu Lu.
       &quot;AttnSense: multi-level attention mechanism for multimodal human activity
       recognition.&quot; In Proceedings of the 28th International Joint Conference on Artificial
       Intelligence, pp. 3109-3115. AAAI Press, 2019.
