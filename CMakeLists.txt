cmake_minimum_required(VERSION 2.8)

project(med_test CXX C)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wpedantic -std=c++11")

find_package(HDF5 REQUIRED)
include_directories(SYSTEM ${HDF5_INCLUDE_DIRS})
set(LIBS ${LIBS} ${HDF5_LIBRARIES})

find_package(Med REQUIRED)
include_directories(SYSTEM ${MED_INCLUDE_DIRS})
set(LIBS ${LIBS} ${MED_LIBRARIES})

find_package(SalomeMED REQUIRED)
include_directories(SYSTEM ${SalomeMED_INCLUDE_DIRS})
set(LIBS ${LIBS} ${SalomeMED_LIBRARIES})

add_executable(main main.cpp)
target_link_libraries(main ${LIBS})

