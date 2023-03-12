cmake_minimum_required(VERSION 3.4.1)  # for example

add_library(ffi

            # 共享库
            SHARED

            # 加载文件.
            ../ios/Classes/include/dart_api_dl.c
            ../ios/Classes/include/dart_api_dl.h
            ../ios/Classes/include/dart_api.h
            ../ios/Classes/include/dart_native_api.h
            ../ios/Classes/include/dart_version.h
            ../ios/Classes/include/internal/dart_api_dl_impl.h
            ../ios/Classes/ffi.cpp )