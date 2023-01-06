import QtQuick

Item
{
    id: doc_root

    /*!
        Holds the source item for opacity mask shader.
    */
    property variant source

    /*!
        Holds the mask source item for creating the mask.
    */
    property variant maskSource

    /*!
        Holds whether to allow the opacity mask shader pixels to be cached in order to improve the performance. Use only for elements, which are not animated.
    */
    property bool cached: false

    // For copying shape form
    ShaderSourceProxy
    {
        id: sourceProxy
        input: doc_root.source
    }

    ShaderSourceProxy
    {
        id: maskSourceProxy
        input: doc_root.maskSource
    }

    // For caching
    ShaderEffectSource
    {
        id: effectSource

        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.width
        height: parent.height
        visible: doc_root.cached

        sourceItem: effect
        smooth: true
        live: true
        hideSource: visible
    }

    ShaderEffect
    {
        id: effect
        anchors.fill: parent

        property variant source: sourceProxy.output
        property variant maskSource: maskSourceProxy.output

        fragmentShader: "qrc:///src/qml_files/ShaderEffects/opacityMaskShader.frag.qsb"

        smooth: true
    }
}
