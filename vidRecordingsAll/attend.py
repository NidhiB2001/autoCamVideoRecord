from facenet_pytorch import MTCNN, InceptionResnetV1
from datetime import datetime
import cv2, os, json, glob
import concurrent.futures
from PIL import Image
import torch

root_dir = os.path.abspath(os.getcwd())
recordings_folder = 'Recordings'  
global path_p, path_a
mtcnn = MTCNN(image_size=160, margin=0, keep_all=True, min_face_size=20)
resnet = InceptionResnetV1(pretrained='vggface2').eval()

vids = []
name_list = []
embedding_list = [] # list of embeding matrix after conversion from cropped faces to embedding matrix using resnet
attendance_dbname = 'studentsAttendance'
stu_regist_db_name = 'registered_students'

# def allvid():
for path, dirc, files in os.walk(root_dir, recordings_folder):
    try:
        if recordings_folder in path:
            # print('recording:', path)
            if 'allvid' in path:
                list_of_files = glob.glob(os.path.join(path,'*'))
                for mkv in list_of_files:
                    vidin = mkv
                    # print('allvidssss', vidin)
                    vids.append(mkv)
                # return vids
    except Exception as e: raise e
                                
# cam_device_file = connect()

# camdata = cam_device_file["Cam_Devices"]
# dbData = [(camdata[j]['device_id'],
#               camdata[j]['tp_id'],
#               camdata[j]['sdc_id'],
#               camdata[j]['device_link']) for j in range(len(camdata))]
# print(':::::::::::::dbData:::\n', dbData)

print("\nAttendance Process started: {}".format((datetime.now()).strftime("%d/%m/%Y %H:%M:%S")))
try:
    print('Model loaded:', os.path.join(root_dir,'Attendance', 'Model','data.pt'))
    load_data = torch.load(os.path.join(root_dir,'Attendance', 'Model','data.pt'))
    embedding_list.append(load_data[0])
    name_list.append(load_data[1])
    path_p =  os.path.join(root_dir,'Attendance', 'Pstudents', (datetime.now()).strftime("%d%m%Y"))
    path_a =  os.path.join(root_dir,'Attendance', 'Astudents', (datetime.now()).strftime("%d%m%Y"))
    mainfrm =  os.path.join(root_dir,'Attendance', 'mainFrames')
    try: os.makedirs(path_p), os.makedirs(path_a), os.makedirs(mainfrm)
    except OSError as e: pass
except Exception as e: raise e


def url_to_video(vid):
    print('video path::--', vid)
    cap = cv2.VideoCapture(vid)
    cap.set(cv2.CAP_PROP_FPS, 60)
    cap.set(cv2.CAP_PROP_BUFFERSIZE, 0)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
    faceRcognition(cap, vid)

def AttendanceLive():
    '''All camera streaming video save simultaniouslly'''
    while True:
        print('ThreadPoolExecutor')
        with concurrent.futures.ThreadPoolExecutor() as executor:
            executor.map(url_to_video, vids)
 
def faceRcognition(video):
    print('fpssssss', video.get(cv2.CAP_PROP_FPS))
    count = 0
    ret = True
    while ret:
        ret, frm = video.read()
        try:
            img = Image.fromarray(frm)
            img_cropped_list, prob_list = mtcnn(img, return_prob=True)
            if img_cropped_list is not None:
                boxes, _ = mtcnn.detect(img)
                dt_string = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
                print(dt_string)
                for i, prob in enumerate(prob_list):
                    if prob > 0.999:
                        emb = resnet(img_cropped_list[i].unsqueeze(0)).detach()
                        dist_list = [] # list of matched distances, minimum distance is used to identify the person
                        for _, emb_db in enumerate(embedding_list[0]):
                            dist = torch.dist(emb, emb_db).item()
                            dist_list.append(dist)
                                                    
                        box = boxes[i]
                        crop = frm[int(box[1]):int(box[3]), int(box[0]):int(box[2])]
                        print('cropppp', type(crop))
                        cv2.imwrite(os.path.join(root_dir,'Attendance', 'mainFrames', 'frame%d_%d_%d.jpg'%(int((datetime.now()).strftime("%H%M%S%f")[:-3]),int(datetime.now().microsecond),count)),crop)
                        
                        min_dist = min(dist_list)
                        min_dist_idx = dist_list.index(min_dist)
                        name = name_list[0][min_dist_idx]
                        try:
                            print('Recognised student name ~~~~~~~~~', name,min_dist)
                            allattendance = [a.split('.')[0] for a in os.listdir(path_p)]
                            # To accurate recognition used 0.78 minimum distance value as a threshold
                            if min_dist < 0.79:
                                if name in allattendance:
                                    print('all attendance:',allattendance)
                                    continue
                                else:
                                    print('cropping time::::::::::::::::::::::: ', dt_string, ' :::::::::::::::::::::::::::::::::')
                                    # qu =  "SELECT class,name FROM "+ stu_regist_db_name + " WHERE uuid ='"+name+"'"
                                    # fetc = surealdb(qu)[0]['result']
                                    # saved_img = os.path.join(path_p, name+'.jpg')
                                    # cv2.imwrite(saved_img, crop)
                                    # print("recognised stu's class___", fetc[0]['class'])
                                    # data = {
                                    #     "name": str(fetc[0]['name']),
                                    #     'attendance_status': 1,
                                    #     'TimeStamp': datetime.now().strftime("%Y-%m-%dT%H:%M:%SZ"),
                                    #     "class": str(fetc[0]['class']),
                                    #     "year_id": datetime.now().strftime("%Y"),
                                    #     "uuid": str(name),
                                    #     "img": saved_img
                                    # }
                                    # json_object = eval(json.dumps(data, indent = 4))
                                    # surealdb(f"CREATE {attendance_dbname} CONTENT {json_object}")
                                  
                            elif min_dist > 0.89:
                                saved_img = os.path.join(path_a, 'Unknown_'+datetime.now().strftime("%d%m%Y%H%M%S")+'.jpg')
                                cv2.imwrite(saved_img, crop)
                            else:
                                saved_img = os.path.join(path_a, str(name)+'_'+datetime.now().strftime("%d%m%Y%H%M%S")+'.jpg')
                                cv2.imwrite(saved_img, crop)
                        except Exception as e:
                            print('Recognition errr:', e)
                            pass
        except: continue
        cv2.waitKey(1)
        count += 1

if __name__ == '__main__':
    AttendanceLive()
    # allvid()
