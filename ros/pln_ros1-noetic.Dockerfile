###############################################################################
# 1 Base Image & installs
###############################################################################
# inspired from triton-AI

FROM ros:noetic
#ROS_DISTRO = galactic

# apt-gets
RUN apt-get update && apt-get install python3-pip -y && apt-get install git -y

# Python setups below
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install opencv-python-headless pillow
RUN apt-get install -y ros-$(rosversion -d)-cv-bridge


###############################################################################
# 2 ROS installs
###############################################################################

RUN mkdir -p /catkin_ws/src

# Python setups below
RUN apt-get install -y ros-noetic-cv-camera
RUN apt-get install -y v4l-utils


###############################################################################
# 3 enter shell
###############################################################################

SHELL ["/bin/bash", "-c"] 
RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash'
#RUN /bin/bash -c 'cd /catkin_ws; catkin_make: source devel/setup.bash'
#RUN /bin/bash
CMD [ "roscore" ]


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