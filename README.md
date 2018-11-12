# petalinux-v2018.2-docker
Install and Run petalinux-v2018.2 by docker


## Prerequisites
1. Clone the git to your <start_dir>
  ```
  $git clone https://github.com/alexhegit/petalinux-v2018.2-docker
  $cd <start_dir>/petalinux-v2018.2-docker
  ```
  
  The file tree looks like 
 ```
 .
  ├── build_docker.sh
  ├── docker_run_plnx_182.sh
  ├── petalinux-182-docker-ubuntu
  │   ├── default.env
  │   ├── Dockerfile
  │   ├── File-Tail-1.3.tar.gz
  │   ├── petalinux-v2018.2
  │   ├── petalinux-v2018.2_bsps
  │   └── plnx_installer.pl
  └── README.md
```


2. Download petalinux v2018.2 install file(petalinux-v2018.2-final-installer.run) from https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html to <start_dir>/petalinux-182-docker-ubuntu/petalinux-v2018.2/

3. Download petalinux BSP v2018.2 file(e.g. xilinx-zcu102-v2018.2-final.bsp) from https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html to <start_dir>/petalinux-182-docker-ubuntu/petalinux-v2018.2_bsps/

## Build the container base on the Dockerfile
1. change to DIR 
2. build the container from Dockerfile
```
e.g.
$sudo docker build ./ --network=host --build-arg version=2018.2 --build-arg date_created=1110 -t petalinux-182-ubuntu:test
build_docker.sh is a example for you.
```
## Start the container
```
e.g.
$sudo docker run --name petalinux-2018.2 --user=plnx_user  --entrypoint=/bin/bash -it -v /home/ahe/PLNX_WS/:/home/plnx_user/PLNX_WS petalinux-182-ubuntu:test
```
The example mount the /home/ahe/PLNX_WS/ from HOST to /home/plnx_user/PLNX_WS/

## Create a project in container
Then you can use petalinux-v2018.2 to build a petalinux project. 
Please refer to UG1144 and UG1157 from www.xilinx.com for using petalinux.
