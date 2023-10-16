import json
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn import metrics,preprocessing
from sklearn.ensemble import RandomForestClassifier
from sklearn.feature_selection import RFE
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix
import random
import typo
from bs4 import BeautifulSoup

def read_json(json_file):
    json_f=open(json_file).read()
    json_info=json.loads(json_f)
    json_data=pd.json_normalize(json_info)

    return json_data
def rfe_get_score(model,num,data,label,test_x,test_y):
     
    rfe = RFE(estimator=LogisticRegression(max_iter=1000), n_features_to_select=num)
    rfe=rfe.fit(data,label)
    x_rfe=rfe.transform(data)
    test_x_rfe=rfe.transform(test_x) 
    model.fit(x_rfe,label)
    fpr,recall=get_base_fpr_tpr(model,test_x,test_y,rfe)
    return model,fpr,recall,rfe 
 
def get_base_fpr_tpr(model,test_x,test_y,selector):
    se_test_x=selector.transform(test_x)
    pre_y=model.predict(se_test_x)  
    cm=confusion_matrix(test_y,pre_y)
    tn=cm[0, 0]
    fp=cm[0, 1]
    fn=cm[1, 0]
    tp=cm[1, 1]
    fpr=fp/(fp+tn)
    
    recall=tp/(tp+fn)
    return fpr,recall

def get_tpr(model,test_x,test_y,selector):
    se_test_x=selector.transform(test_x)
    pre_y=model.predict(se_test_x)
    cm=confusion_matrix(test_y,pre_y)
    try:
        fn=cm[1, 0]
        tp=cm[1, 1]
        recall=tp/(tp+fn)
        return recall
    except:
#         print('pre_y is',pre_y)
#         print('test_y is',test_y)
        if operator.eq(test_y.all(),pre_y.all()):
#             print('recall',1)
            return 1
        else:
#             print('recall',0)
            return 0  
# generate apw samples
def readHtmlFile(path):
    try:
        with open(path,'r') as f: 
            ht=f.read()
    except:
        with open(path, encoding="latin-1") as f:
            ht=f.read()
    return ht
def add_typos(ht,out_file):
    soup1 = BeautifulSoup(ht,"html.parser")
    texts=soup1.get_text()
    texts=texts.replace('\t','') 
    new_texts=texts.split('\n')
    for i in new_texts:
        if len(i)>1:
            seed2=random.randint(1,200)
            
            strerr=typo.StrErrer(i,seed=seed2)
            later_te=strerr.nearby_char().result
             
            ht=ht.replace(i,later_te)

    with open(out_file, 'w') as out:
        out.write(ht)
        
def add_large_image(ht,out_file):
    soup = BeautifulSoup(ht,"html.parser")
    ind=ht.find("</head>")
    content="<style>body {background-image:url('../../datasets/back_10.jpg');}</style>"
    final_string=ht[:ind]+content+ht[ind:]
    with open(out_file, 'w') as out:
        out.write(final_string)
    print('success',out_file)
    
def add_image_footer(ht,out_file):
    #add all images
    folder="../../datasets/noiseimg/"
    soup = BeautifulSoup(ht,"html.parser")
    ind=ht.find("</footer>")
    content=""
    if ind==-1:
        print('no footer, need add')
        ind=ht.find("</body>")
        content="<footer style='position: absolute;bottom:0;'>"
        #print('folder is',os.listdir(folder))
        
        for image in os.listdir(folder):
            #print('image is',image)
            string="<img src='../../datasets/noiseimg/"+image+"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            print('string is',string)
            content=content+string
    if ht.find("</footer>")==-1:
        content=content+"</footer>"
    print('content is',content)
    final_string=ht[:ind]+content+ht[ind:]
    with open(out_file, 'w') as out:
        out.write(final_string)
        
def replace_password(ht,out_file):
    soup=BeautifulSoup(ht,"html.parser")
    #print('inputs is',soup.findAll('input'))
    inputs=soup.findAll('input',type=True)
    
    for inp in inputs:
        if inp['type']=='password':
            #print('type is',inp['type'])
            inp['type']='text'
    #print('soup is',soup)
    with open(out_file, 'w') as out:
        out.write(str(soup))