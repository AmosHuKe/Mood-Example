cmake_minimum_required(VERSION 3.4.1)

# 项目名称
set(PROJECT_NAME "ffi")

# 批量添加c文件
file(GLOB_RECURSE ffi ../ios/Classes/*)
# 构建链接库 add_library(包名称 SHARED:构建动态链接库 源文件列表)
add_library(${PROJECT_NAME} SHARED ${ffi})