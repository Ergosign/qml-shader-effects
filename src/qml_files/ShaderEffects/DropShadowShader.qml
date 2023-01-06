import QtQuick

Item
{
    id: doc_root

    /*!
        Holds the source item for rendering a drop shadow.
    */
    property variant source

    /*!
        Holds the shadow horizontal offset.
    */
    property int horizontalOffset: 0

    /*!
        Holds the shadow vertical offset.
    */
    property int verticalOffset: 0

    /*!
        Holds the shadow color. Default is black.
    */
    property color color: "black"

    /*!
        Holds whether use radial shadow calculations. Default is directional shadow calculation.
    */
    property bool radial: false

    /*!
        Holds shadow blur strength. Default value is 1. Maximum value is 2.
    */
    property real blurStrength: 1

    /*!
        Holds whether the source element has a transparent border, this concerns bluring edges.
    */
    property bool transparentBorder: false

    /*!
        Holds the samples count, which is taken per pixel for blur calculation.
    */
    property int samples: 10

    /*!
        Holds whether to allow the drop shadow pixels to be cached in order to improve the performance. Use only for elements, which are not animated.
    */
    property bool cache: false

    // For copying shape form
    ShaderSourceProxy
    {
        id: sourceProxy
        input: doc_root.source
        sourceRect: doc_root.transparentBorder ? Qt.rect(-1, -1, parent.width + 1.0, parent.height + 1.0) : Qt.rect(0, 0, 0, 0)
    }

    // For caching
    ShaderEffectSource
    {
        id: effectSource

        anchors.fill: parent
        visible: doc_root.cache

        sourceItem: effect
        smooth: true
        live: true
        hideSource: visible
    }

    ShaderEffect
    {
        id: effect
        anchors.fill: parent

        property real xOffset: doc_root.horizontalOffset
        property real yOffset: doc_root.verticalOffset
        property bool radial: doc_root.radial
        property color targetColor: doc_root.color
        property variant source: sourceProxy.output
        property real strength: doc_root.blurStrength <= 2 ? doc_root.blurStrength : 2
        property variant center: Qt.point(0.5 + xOffset / parent.width, 0.5 + yOffset / parent.height)
        property int samples: doc_root.samples

        vertexShader: "qrc:///src/qml_files/ShaderEffects/dropShadowShader.vert.qsb"
        fragmentShader: "qrc:///src/qml_files/ShaderEffects/dropShadowShader.frag.qsb"

        smooth: true
    }
}
