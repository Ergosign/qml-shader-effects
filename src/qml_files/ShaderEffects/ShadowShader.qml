import QtQuick
import ShaderEffects

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
        Holds the samples count, which is taken per pixel for radial blur calculation.
    */
    property int samples: 10

    /*!
        Holds whether to allow the drop shadow pixels to be cached in order to improve the performance. Use only for elements, which are not animated.
    */
    property bool cache: false

    Loader
    {
        width: parent.width
        height: parent.height
        sourceComponent: dropShadowShader
    }

    Component
    {
        id: dropShadowShader
        DropShadowShader
        {
            anchors.fill: parent
            source: sourceProxy.output
            color: doc_root.color
            cache: doc_root.cache
            samples: doc_root.samples
            radial: doc_root.radial
            blurStrength: doc_root.blurStrength
            horizontalOffset: doc_root.horizontalOffset
            verticalOffset: doc_root.verticalOffset
            transparentBorder: doc_root.transparentBorder
        }
    }

    // For copying shape form
    ShaderSourceProxy
    {
        id: sourceProxy
        input: doc_root.source
        sourceRect: doc_root.transparentBorder ? Qt.rect(-1, -1, parent.width + 1.0, parent.height + 1.0) : Qt.rect(0, 0, 0, 0)
    }

    ShaderEffect
    {
        anchors.fill: parent
        property variant source: sourceProxy.output
    }
}
