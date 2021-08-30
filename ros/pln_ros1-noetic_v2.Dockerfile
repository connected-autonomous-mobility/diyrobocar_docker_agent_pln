###############################################################################
# 1 Base Image & installs
###############################################################################
# inspired from triton-AI

FROM dustynv/ros:noetic-ros-base-l4t-r32.6.1
#ROS_DISTRO = galactic

# apt-gets
RUN mkdir -p /root/dev
RUN apt-get update && apt-get install python3-pip -y && apt-get install git -y

# Python setups below
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install opencv-python-headless pillow
#RUN apt-get install -y ros-$(rosversion -d)-cv-bridge
#RUN apt-get install -y ros-galactic-cv-bridge
RUN cd /root/dev; git clone https://github.com/JetsonHacksNano/CSI-Camera.git


###############################################################################
# 2 ROS installs
###############################################################################

RUN mkdir -p /catkin_ws/src

# Python setups below
#RUN apt-get install -y ros-noetic-cv-camera
#RUN apt-get install -y v4l-utils


###############################################################################
# 3 enter shell
###############################################################################

SHELL ["/bin/bash", "-c"] 
RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash'
#RUN /bin/bash -c 'cd /catkin_ws; catkin_make: source devel/setup.bash'
#RUN /bin/bash
CMD [ "roscore" ]

