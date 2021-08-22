###############################################################################
# 1 Base Image & installs
###############################################################################
# inspired from triton-AI

FROM ros:galactic
#ROS_DISTRO = galactic

# apt-gets
RUN apt-get update && apt-get install python3-pip -y && apt-get install git -y


###############################################################################
# 2 ROS installs
###############################################################################

RUN mkdir -p /root/ros2_ws/src

# ROS setups
RUN apt-get install -y ros-galactic-camera-calibration-parsers
RUN apt-get install -y ros-galactic-camera-info-manager
RUN apt-get install -y ros-galactic-launch-testing-ament-cmake
RUN cd /root/ros2_ws; git clone -b ros2 https://github.com/ros-perception/image_pipeline.git


#RUN apt-get install ros-$(ROS_DISTRO)-ackermann-msgs

# Python setups below
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install opencv-python-headless pillow
RUN apt-get install -y ros-$(rosversion -d)-cv-bridge
RUN python3 -m pip install opencv-python
RUN python3 -m pip install simple-pid
RUN python3 -m pip install matplotlib
RUN python3 -m pip install -U scikit-learn

#RUN apt-get install -y ros-$(rosversion -d)-cv-camera


###############################################################################
# 3 enter shell
###############################################################################

SHELL ["/bin/bash", "-c"] 
RUN /bin/bash -c 'cd /home/root;. .bashrc; source /opt/ros/galactic/setup.bash'
#RUN /bin/bash


#"""
#CMake Error at CMakeLists.txt:13 (find_package):
#  By not providing "Findament_cmake_auto.cmake" in CMAKE_MODULE_PATH this
#  project has asked CMake to find a package configuration file provided by
#  "ament_cmake_auto", but CMake did not find one.
#
#  Could not find a package configuration file provided by "ament_cmake_auto"
#  with any of the following names:
#
#    ament_cmake_autoConfig.cmake
#    ament_cmake_auto-config.cmake
#
#  Add the installation prefix of "ament_cmake_auto" to CMAKE_PREFIX_PATH or
#  set "ament_cmake_auto_DIR" to a directory containing one of the above
#  files.  If "ament_cmake_auto" provides a separate development package or
#  SDK, be sure it has been installed.
#"""