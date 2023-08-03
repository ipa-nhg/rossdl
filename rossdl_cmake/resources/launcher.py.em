# generated from rossdl_cmake/resource/launcher.py.em
# DO NOT EDIT THIS FILE
# generated code does not contain a copyright notice

@{
from rossdl_cmake import get_system_nodes
from rossdl_cmake import get_system_remappings
from rossdl_cmake import get_system_parameters


system_name = locals()['system']
package_name = locals()['package']
systems_data = locals()['systems_data']
arfifacts = locals()['artifacts']

system_info = systems_data[package_name]['systems'][system_name]

remappings = get_system_remappings(system_info, arfifacts)
parameters = get_system_parameters(system_info, arfifacts)
}@

from launch_ros.actions import ComposableNodeContainer, LoadComposableNodes
from launch_ros.descriptions import ComposableNode
from launch import LaunchDescription
from launch_ros.actions import Node
from launch.conditions import IfCondition
from launch.substitutions import LaunchConfiguration
from launch.actions import DeclareLaunchArgument

def generate_launch_description():

    create_container = LaunchConfiguration('create_container')
    container_name = LaunchConfiguration('container_name')

    declare_create_container_cmd = DeclareLaunchArgument(
        'create_container',
        default_value='True',
        description='Whether run a container')

    declare_container_name_cmd = DeclareLaunchArgument(
        'container_name',
        default_value='rossdl_test_container',
        description='Name of the container')

    container_cmd = Node(
        condition=IfCondition(create_container),
        name=container_name,
        package='rclcpp_components',
        executable='component_container',
        output='both',
    )

    load_composable_nodes = LoadComposableNodes(
        target_container=container_name,
            composable_node_descriptions=[
@{
system_nodes = get_system_nodes(system_info)
}@
@[for node in system_nodes]@
@{
package = node[1].split('::')[0]
node_name = node[0]
}@
                ComposableNode(
                    package = '@(package)',
                    plugin = '@(node[1])',
                    name = '@(node_name)',
                    remappings = [
@[  for remap in remappings[node_name]]@
                        @(remap),
@[  end for]                    ],
                    parameters=[{
@[  if node_name in list(parameters)]@
@[      for parameter in parameters[node_name]]@
@{
param_key = parameter[0]
param_value = parameter[1]
}@[         if isinstance(param_value, str)]@
                        '@(param_key)': '@(param_value)',
@[          else]@
                        '@(param_key)': @(param_value),
@[          end if]@
@[      end for]@
@[    end if]@                     }],
                ),
@[end for]@
    ])

    ld = LaunchDescription()

    ld.add_action(declare_create_container_cmd)
    ld.add_action(declare_container_name_cmd)
    ld.add_action(container_cmd)
    ld.add_action(load_composable_nodes)

    return ld
