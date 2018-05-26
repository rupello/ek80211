#!env python3
import sys
import os
import time
import requests


def new_file(logdir):
    path = os.path.join(logdir, "{}.log".format(int(time.time()*1e6)))
    return open(path,"w"), path

def upload(path):
    headers = {"Content-Type": "application/x-ndjson"}
    data = open(path).read()
    r = requests.post("http://localhost:9200/_bulk",
                      data=data,headers=headers)
    print(r.status_code)

if __name__ == '__main__':
    log_files = []
    maxlines = int(os.environ.get("PYLOGD_MAXLINES",1000))
    logdir = os.environ.get("PYLOGD_LOGDIR",'./logs')
    maxfiles = int(os.environ.get("PYLOGD_MAXFILES",1))
    cmd = os.environ.get("PYLOGD_CMD",'')
    counter = 0
    assert os.path.exists(logdir)
    f,p = new_file(logdir)
    log_files.insert(0,p)
    for line in sys.stdin:
        f.writelines(line)
        counter += 1
        if counter >= maxlines:
            f.close()
            upload(p)
            f,p = new_file(logdir)
            counter = 0
            log_files.insert(0,p)
            while(len(log_files)>maxfiles):
                path  = log_files.pop()
                os.unlink(path)
