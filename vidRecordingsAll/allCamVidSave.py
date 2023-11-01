
import cv2, os, time, datetime, glob, shutil
from multiprocessing import Process
import concurrent.futures
import subprocess
from mySqConnect import *

root_dir = os.path.abspath(os.getcwd())
recordings_folder = 'Recordings'
cam_device_file = connect()

camdata = cam_device_file["Cam_Devices"]
dbData = [(camdata[j]['device_id'],
              camdata[j]['tp_id'],
              camdata[j]['sdc_id'],
              camdata[j]['device_link'],
              camdata[j]['sdc_name']) for j in range(len(camdata))]
print(':::::::::::::dbData:::\n', dbData)

def url_to_video(tup):
    tp, ind, sdc ,url, sdc_name = tup         # here tp & ind temporary sequence need to interchange because tp was same 1
    print(url)   # foldr = re.sub('[^A-Za-z0-9]+', '', url)
    try: os.makedirs(os.path.join(root_dir,recordings_folder,str(tp),str(sdc), 'temp'))
    except OSError as e: pass
    video = cv2.VideoCapture(url)
    l = os.listdir(os.path.join(root_dir,recordings_folder,str(tp),str(sdc)))
    try: [os.remove(os.path.join(root_dir,recordings_folder,str(tp),str(sdc), v)) for v in l if v.endswith(".mkv")]
    except : pass

    while True:
        ret, frame = video.read()
        fourcc = cv2.VideoWriter_fourcc(*'XVID')   # 'M', 'J', 'P', 'G'
        capture_duration = 11   # video recording for 2 minutes
        d = datetime.datetime.now().strftime("_%Y%m%d%H%M%S")
        h,w,_ = frame.shape
        fps = int(video.get(cv2.CAP_PROP_FPS))
        print('fps>>>>>>>', ret, url, fps, h,w)
        vidname = os.path.join(root_dir,recordings_folder,str(tp),str(sdc), str(d)+'-'+str(sdc_name)+'.mkv')
        out = cv2.VideoWriter(vidname, fourcc, 60, (w, h),1)
        start_time = time.time()
        while( int(time.time() - start_time) < capture_duration ):
            ret, frame = video.read()
            # print(int(time.time() - start_time))
            out.write(frame)
        print("saved*************", vidname,'\n\n')
        shutil.move(vidname, os.path.join(root_dir,recordings_folder,str(tp),str(sdc), 'temp'))
       
def recorder():
    '''All camera streaming video save simultaniouslly'''
    while True:
        print('ThreadPoolExecutor')
        with concurrent.futures.ThreadPoolExecutor() as executor:
            executor.map(url_to_video, dbData)

def vidCompress():
    '''check video file in temp folder on every 123 seconds'''
    time.sleep(13)
    print("videcompress start")
    # iterating over directory and subdirectory to get desired video path
    for path, dirc, files in os.walk(root_dir, recordings_folder):
        if recordings_folder in path:
            list_of_files = glob.glob(os.path.join(path,'temp','*'))
            try:
                for mkv in list_of_files:
                    vidin = mkv
                    vidname = (os.path.split(os.path.abspath(mkv))[-1]).replace('_', "")
                    temp_path = os.path.join(os.path.split(os.path.abspath(mkv))[0])
                    vid_folder = os.path.join(temp_path.replace(os.path.basename(os.path.normpath(temp_path)),''))
                    print('vid_foldervid_folder', vid_folder)
                    try: os.mkdir(os.path.join(vid_folder,'allvid'))
                    except: pass
                    vidout = os.path.join(vid_folder,'allvid',vidname)
                    ######## "Fast Forward Moving Picture Expaerts Group" : ffmpeg
                    subprocess.run(f"ffmpeg -i {vidin} -b 50k {vidout}", shell=True)
                    print(f'{"compressed":_^80}','\n')
                    os.remove(mkv)
            except Exception as e:
                print('compress error::\n', e)
                pass
        else: continue
    vidCompress()
    
if __name__ == '__main__':
    Process(target=recorder).start()
    Process(target=vidCompress).start()
