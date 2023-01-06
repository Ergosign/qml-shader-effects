cmake_minimum_required(VERSION 3.17)

project(qml_shader_effects_qt6 VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_EXAMPLE "Set to ON to build example project" OFF)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Widgets ShaderTools)

#sum up project Files
file(GLOB_RECURSE QML_SHADER_EFFECTS_SOURCES
    ${CMAKE_CURRENT_LIST_DIR}/src/*.cpp
    )

file(GLOB_RECURSE QML_SHADER_EFFECTS_HEADER
    ${CMAKE_CURRENT_LIST_DIR}/src/*.h
    )

qt6_add_resources(QML_SHADER_EFFECTS_RESOURCES ${CMAKE_CURRENT_LIST_DIR}/src/qml_files/qml.qrc)

add_library(qml_shader_effects_qt6
    SHARED
    ${QML_SHADER_EFFECTS_SOURCES}
    ${QML_SHADER_EFFECTS_HEADER}
    ${QML_SHADER_EFFECTS_RESOURCES}
    ${CMAKE_CURRENT_LIST_DIR}/src/qml_files/ShaderEffects/qmldir
)

target_include_directories(qml_shader_effects_qt6
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
)

target_link_libraries(qml_shader_effects_qt6
    PUBLIC 
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Widgets
    Qt${QT_VERSION_MAJOR}::ShaderTools
    )

set_target_properties(qml_shader_effects_qt6 PROPERTIES
  WIN32_EXECUTABLE TRUE
  MACOSX_BUNDLE TRUE
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml/ShaderEffects/"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml/ShaderEffects/"
)

if(${BUILD_EXAMPLE})
    add_subdirectory(example)
endif()

qt6_add_shaders(qml_shader_effects_qt6 "qml_shader_effects_qt6_shaders"
    BATCHABLE
    #PRECOMPILE -> Causes write error on disc
    #OPTIMIZED
    PREFIX "/"
    FILES
    "src/qml_files/ShaderEffects/colorOverlayShader.frag"
    "src/qml_files/ShaderEffects/dropShadowShader.vert"
    "src/qml_files/ShaderEffects/dropShadowShader.frag"
    "src/qml_files/ShaderEffects/opacityMaskShader.frag"
    )

# configure *.cmake File
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    qml_shader_effects_qt6Version.cmake
    VERSION ${PACKAGE_VERSION}
    COMPATIBILITY AnyNewerVersion
    )

# Copy ShaderEffects to binary dir
add_custom_command(
        TARGET qml_shader_effects_qt6
        COMMAND ${CMAKE_COMMAND} -E copy
                "${CMAKE_CURRENT_SOURCE_DIR}/src/qml_files/ShaderEffects/qmldir"
                "${CMAKE_BINARY_DIR}/qml/ShaderEffects/qmldir"
        BYPRODUCTS ${CMAKE_BINARY_DIR}/qml/ShaderEffects/qmldir
)

# Install files
install(TARGETS qml_shader_effects_qt6 DESTINATION qml/ShaderEffects)
install(FILES ${CMAKE_BINARY_DIR}/qml/ShaderEffects/qmldir DESTINATION qml/ShaderEffects)

