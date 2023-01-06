import QtQuick

Item
{
    id: doc_root

    /*!
        Holds the source image for coloring.
    */
    property alias source: effect.source

    /*!
        Holds the target color to be applied.
    */
    property alias targetColor: effect.targetColor

    ShaderEffect
    {
        id: effect
        anchors.fill: parent

        property variant source
        property color targetColor

        fragmentShader: "qrc:///src/qml_files/ShaderEffects/colorOverlayShader.frag.qsb"
    }
}
