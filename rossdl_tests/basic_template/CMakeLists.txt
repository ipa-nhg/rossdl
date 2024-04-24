cmake_minimum_required(VERSION 3.8)
project(basic_template)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rossdl_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_components REQUIRED)
find_package(backward_ros REQUIRED)
# Add here further dependencies
find_package(std_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)

set(dependencies
  rclcpp
  rclcpp_components
  backward_ros
  # Add here further dependencies
  std_msgs
  sensor_msgs
)

rossdl_generate_code(
  "rosnodes/node.ros2"
  ${dependencies}
)

ament_package()