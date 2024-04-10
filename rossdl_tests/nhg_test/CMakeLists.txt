cmake_minimum_required(VERSION 3.8)
project(nhg_test2)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rossdl_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_components REQUIRED)
find_package(std_msgs REQUIRED)
find_package(backward_ros REQUIRED)

set(dependencies
  rclcpp
  rclcpp_components
  backward_ros
  std_msgs
)

rossdl_generate_code(
  "rosnodes/examples_rclcpp_minimal_publisher.ros2"
  ${dependencies}
)

rossdl_generate_system(
  "pub_sub_system.rossystem"
  "system"
)

ament_package()
