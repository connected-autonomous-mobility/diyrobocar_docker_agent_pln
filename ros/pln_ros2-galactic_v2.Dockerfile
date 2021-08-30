###############################################################################
# 1 Base Image & installs
###############################################################################
# inspired from triton-AI

FROM dustynv/ros:galactic-ros-base-l4t-r32.6.1
#ROS_DISTRO = galactic

# apt-gets
RUN mkdir -p /root/dev
RUN apt-get update && apt-get install python3-pip -y && apt-get install git -y
RUN apt-get install -y vim

RUN sudo usermod -a -G video root

RUN cd /root/dev; git clone https://github.com/hustvl/YOLOP.git
RUN cd /root/dev; git clone https://github.com/JetsonHacksNano/CSI-Camera.git
RUN cd /root/dev; git clone https://github.com/dusty-nv/jetson-inference.git


###############################################################################
# 2 ROS installs
###############################################################################

RUN mkdir -p /root/ros2_ws/src

# ROS setups
#RUN apt-get install -y ros-galactic-camera-calibration-parsers
#RUN apt-get install -y ros-galactic-camera-info-manager
#RUN apt-get install -y ros-galactic-launch-testing-ament-cmake
#RUN cd /root/ros2_ws; git clone -b ros2 https://github.com/ros-perception/image_pipeline.git


#RUN apt-get install ros-$(ROS_DISTRO)-ackermann-msgs

# Python setups below
#RUN python3 -m pip install --upgrade pip
#RUN python3 -m pip install opencv-python-headless pillow
#RUN apt-get install -y ros-$(rosversion -d)-cv-bridge
#RUN python3 -m pip install opencv-python
#RUN python3 -m pip install simple-pid
#RUN python3 -m pip install matplotlib
#RUN python3 -m pip install -U scikit-learn

#RUN apt-get install -y ros-$(rosversion -d)-cv-camera


###############################################################################
# 3 enter shell
###############################################################################

#SHELL ["/bin/bash", "-c"] 
#RUN /bin/bash -c 'cd /home/root;. .bashrc; source /opt/ros/galactic/setup.bash'
#RUN /bin/bash


