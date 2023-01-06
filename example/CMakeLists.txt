cmake_minimum_required(VERSION 3.17)
project(qt_dialog_system_example VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

#sum up project Files
file(GLOB SOURCES
    *.cpp
    )

file(GLOB HEADER
    *.h
    )
file(GLOB RESOURCES
    *.qrc
    )

add_executable(qml_shader_effects_qt6_example
    ${SOURCES}
    ${HEADER}
    ${RESOURCES}
)

target_link_libraries(qml_shader_effects_qt6_example
    PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

target_compile_definitions(qml_shader_effects_qt6_example
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
