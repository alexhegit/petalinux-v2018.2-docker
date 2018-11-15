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
  ├── docker_run_plnx_182.sh
  ├── petalinux-182-docker-ubuntu
  │   ├── build_docker.sh
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

**NOTE**
You may need modify the proxy settings in Dockerfile according to your enviroment.

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

## Enalbe local sstate-cache
As you know, petalinux is base on Yocto. You can speed up the building process by using sstate-cache. Petalinux use online sstae-cache as default setting. To avoid the unstable network connection, you download the sstate-cache from  https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html and put the DIR mounted by the container. As this example, unzip the sstate_cache.tar.gz and put it into /home/ahe/PLNX_WS/ at host side and you can get it bellow /home/plnx_user/PLNX_WS/

The dir tree looks like bellow.
```
/home/ahe/PLNX_WS/sstate-rel-v2018.2/
├── aarch64
├── arm
├── downloads
├── file
├── filelist.txt
├── mb-full
├── mb-lite
├── output_arm_univ_tgz.txt
├── output_mbfull_univ_tgz.txt
└── output_mblite_univ_tgz.txt
```
- The *aarch64* is for Zynq MPSoC and *arm* is for Zynq SoC. 
- The *download* is the source code package

### Set local sstate_cache
run petalinux-config to get the settings through petalinux-config-->Yocto-Settings-->Local sstate feeds
settings and enter the full path of the sstate directory. 
As this example for zcu102(Zynq MPSoC), the sstate directory should be /home/plnx_user/PLNX_WS/sstate-rel-v2018.2/aarch64/
If your porject is for Zynq, it should be /home/plnx_user/PLNX_WS/sstate-rel-v2018.2/arm/.

### Set local source mirrors
petalinux-config -> Yocto-Settings -> Add pre-mirror url -->
Enter with file://<path of source>   
e.g. here is /home/plnx_user/PLNX_WS/sstate-rel-v2018.2/downloads/

### Disable Network sstate feeds (optional)
Deselect petalinux-config-->Yocto-Settings-->Enable Network sstate feeds

### Force do fetching from local (optional)
Select petalinux-config-->Yocto-Settings--> Enable BB NO NETWORK


Then you can build the project with local sstate_cache and source mirrors. More details of these settings are in UG1144.
