# Base image
#FROM ubuntu:bionic
FROM nvidia/cuda:11.2.1-base-ubuntu18.04
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get remove python-*
RUN apt-get update && apt-get install -y lsb-release gnupg2 curl && apt-get clean all
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -
RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip python3-yaml git build-essential cmake nano libtool m4 automake byacc bison flex libxml2-dev libxml2 2to3 vim
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install opencv-python --upgrade
RUN python3 -m pip install python-igraph==0.8.2

RUN apt-get install -y python3-igraph # rbx

RUN python3 -m pip install numpy scipy pyyaml rospkg configparser zmq igraph trajectory_planning_helpers scikit-build cmake catkin_pkg rosdep rosinstall_generator rosinstall wstool vcstools catkin_tools pandas tensorflow


RUN rosdep init
RUN rosdep update
ENV ROS_PYTHON_VERSION=3
# Creating a catkin workspace
RUN mkdir -p /catkin_ws/data
RUN mkdir -p /catkin_ws/src
RUN cd /catkin_ws && catkin config --init -DCMAKE_BUILD_TYPE=Release --blacklist rqt_rviz rviz_plugin_tutorials librviz_tutorial --install
RUN cd /catkin_ws && rosinstall_generator ros_base --rosdistro melodic --deps --tar > melodic-desktop-full.rosinstall
RUN cd /catkin_ws && wstool init -j8 src melodic-desktop-full.rosinstall
RUN pip3 install -U -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-18.04 wxPython
RUN apt remove -y python3-numpy

# DIYrobocars setup
RUN git clone https://github.com/autorope/donkeycar
RUN cd /donkeycar; git checkout dev; pip install -e .[pc]
#COPY ./mycar  /root/mycar
COPY ./race8  /root/race8
#------> COPY ./myrace /root/myrace <------

RUN git clone https://github.com/tawnkramer/gym-donkeycar
RUN pip install -e gym-donkeycar

#CMD /bin/bin - "cd /root/race8"
#CMD /bin/bash  -c "python /root/rC3car/test_client.py"
#CMD /bin/bash  -c "source /catkin_ws/devel/setup.bash; cd /catkin_ws; catkin_make; roslaunch --wait pln5 pln-gbltp_pd_controller_racer.launch"
#CMD /bin/bash  -c "python3 /root/race7/manage.py drive --model=/root/race7/models/warren_pln5.h5; python3 /root/race7/monitor_client.py"
#CMD /bin/bash -c "/root/race7/pln_startscript.sh"
