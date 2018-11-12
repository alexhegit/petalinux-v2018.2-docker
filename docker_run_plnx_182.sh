sudo docker run --name petalinux-2018.2 -p 5902:5902 --user=plnx_user  --entrypoint=/bin/bash -it -v /home/ahe/PLNX_WS/:/home/plnx_user/PLNX_WS petalinux-182-ubuntu:test
