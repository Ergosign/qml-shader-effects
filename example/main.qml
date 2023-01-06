import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import ShaderEffects

Rectangle
{
    id: doc_root

    width: 480
    height: 840

    Flickable
    {
        anchors.fill: parent
        anchors.margins: 16
        clip: true
        flickableDirection: Flickable.VerticalFlick
        contentHeight: column.height

        ScrollBar.vertical: ScrollBar
        {
            id: scrollBar
        }

        Column
        {
            id: column

            // anchors.centerIn: parent
            spacing: 12

            Item
            {
                width: logoImage.sourceSize.width + 100
                height: logoImage.sourceSize.height + 100

                ShadowShader
                {
                    id: directionalDropShadowLogo
                    anchors.fill: logoImage
                    source: logoImage
                    verticalOffset: 1
                    horizontalOffset: 1
                    color: "black"
                }

                Image
                {
                    id: logoImage
                    anchors.fill: parent
                    sourceSize.width: 166
                    sourceSize.height: 53
                    fillMode: Image.PreserveAspectFit
                    cache: true

                    source: "qrc:///Ergosign_dark_RGB.svg"
                    visible: true

                    MouseArea
                    {
                        id: imageAreaLogo
                        hoverEnabled: true
                        anchors.fill: parent
                    }

                    ToolTip.visible: imageAreaLogo.containsMouse
                    ToolTip.text: qsTr("Image with color with some transparency. Black shadow with vertical/horizontal offset of 1, 1 pixel.")
                }
            }

            Item
            {
                width: originalButton.width
                height: originalButton.height

                Button
                {
                    id: originalButton
                    text: "Hello World!"
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Original button without shadow.")
                }
            }

            Item
            {
                width: button.width
                height: button.height

                Button
                {
                    id: button
                    text: "Hello World!"
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Black shadow with with no offset and default blur strength 1.")
                }

                ShadowShader
                {
                    anchors.fill: button
                    source: button
                }
            }

            Item
            {
                width: button2.width
                height: button2.height

                Button
                {
                    id: button2
                    text: "Hello World!"
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Black shadow with vertical/horizontal offset of 2 pixel and maximum blur strength (2).")
                }

                ShadowShader
                {
                    anchors.fill: button2
                    source: button2
                    verticalOffset: 2
                    horizontalOffset: 2
                    blurStrength: 2
                    color: "black"
                }
            }

            Item
            {
                width: button3.width
                height: button3.height

                ShadowShader
                {
                    anchors.fill: button3
                    source: button3
                    verticalOffset: 4
                    horizontalOffset: 4
                    color: "black"
                    samples: 25
                    radial: true
                    cache: true
                    transparentBorder: true
                }

                Button
                {
                    id: button3
                    text: "Hello World!"

                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Cached black shadow with vertical/horizontal offset of 4 pixel default blur strength (1), radial, 25 samples and transparent border.")
                }

                ShadowShader
                {
                    anchors.fill: button3
                    source: button3
                }
            }

            Item
            {
                width: sourceImage.sourceSize.width
                height: sourceImage.sourceSize.height

                Image
                {
                    id: sourceImage
                    anchors.fill: parent
                    sourceSize.width: 125
                    sourceSize.height: 96
                    fillMode: Image.PreserveAspectFit
                    cache: true

                    source: "qrc:///animal-duck.svg"
                    visible: true

                    MouseArea
                    {
                        id: imageArea
                        hoverEnabled: true
                        anchors.fill: parent
                    }

                    ToolTip.visible: imageArea.containsMouse
                    ToolTip.text: qsTr("The original image.")
                }
            }

            Item
            {
                width: sourceImage1.sourceSize.width
                height: sourceImage1.sourceSize.height

                ShadowShader
                {
                    id: directionalDropShadow
                    anchors.fill: sourceImage1

                    source: sourceImage1
                    verticalOffset: -4
                    horizontalOffset: 4
                    color: "black"
                    transparentBorder: true
                }

                Image
                {
                    id: sourceImage1
                    anchors.centerIn: parent
                    sourceSize.width: 125
                    sourceSize.height: 96
                    cache: true

                    source: "qrc:///animal-duck.svg"
                    visible: true

                    MouseArea
                    {
                        id: imageArea1
                        hoverEnabled: true
                        anchors.fill: parent
                    }

                    ToolTip.visible: imageArea1.containsMouse
                    ToolTip.text: qsTr("Image with color overlay with red color with some transparency. Black shadow with vertical/horizontal offset of -8, 8 pixel.")
                }

                ColorOverlayShader
                {
                    anchors.fill: sourceImage1
                    source: sourceImage1
                    targetColor: "#80800000"
                }
            }

            Item
            {
                width: sourceImage1.sourceSize.width
                height: sourceImage1.sourceSize.height

                Image
                {
                    id: sourceImage2
                    anchors.fill: parent
                    sourceSize.width: 125
                    sourceSize.height: 96
                    cache: true

                    source: "qrc:///animal-duck.svg"
                    visible: true

                    MouseArea
                    {
                        id: imageArea2
                        hoverEnabled: true
                        anchors.fill: parent
                    }

                    ToolTip.visible: imageArea2.containsMouse
                    ToolTip.text: qsTr("Image with color overlay with yellow color with some transparency. Black shadow with vertical/horizontal offset of -6, 6 pixel, radial, 25 samples, just 0.1 blur strength and transparent border.")
                }

                ShadowShader
                {
                    id: radialDropShadow
                    anchors.fill: sourceImage2
                    source: sourceImage2
                    verticalOffset: -4
                    horizontalOffset: 4
                    color: "black"
                    radial: true
                    samples: 10
                    blurStrength: 0.5
                    transparentBorder: true
                }

                ColorOverlayShader
                {
                    anchors.fill: sourceImage2
                    source: sourceImage2
                    targetColor: "#80808000"
                }
            }

            Item
            {
                width: sourceImage3.sourceSize.width
                height: sourceImage3.sourceSize.height

                MouseArea
                {
                    id: imageArea3
                    hoverEnabled: true
                    anchors.fill: parent
                }

                ToolTip.visible: imageArea3.containsMouse
                ToolTip.text: qsTr("Image with color overlay with darker color with some transparency. Black shadow with animated vertical/horizontal offset.")

                ShadowShader
                {
                    id: dropShaderDuck
                    anchors.fill: sourceImage3
                    source: sourceImage3
                    color: "black"

                    NumberAnimation on verticalOffset
                    {
                        from: 0; to: 8; duration: 2000; loops: 1
                    }

                    NumberAnimation on horizontalOffset
                    {
                        from: 0; to: 8; duration: 2000; loops: 1
                    }
                }

                Image
                {
                    id: sourceImage3
                    anchors.fill: parent
                    sourceSize.width: 125
                    sourceSize.height: 96
                    cache: true

                    source: "qrc:///animal-duck.svg"
                    visible: false
                }

                DropShadowShader
                {
                    source: sourceImage
                    verticalOffset: -4
                    horizontalOffset: 4
                    color: "black"
                }

                ColorOverlayShader
                {
                    anchors.fill: sourceImage3
                    source: sourceImage3
                    targetColor: "#800000FF"
                }
            }

            Item
            {
                width: slider.width + 2
                height: slider.height + 2

                Row
                {
                    height: slider.height
                    spacing: 8

                    Slider
                    {
                        id: slider
                        from: 0
                        to: 8
                        stepSize: 0.2
                        value: 8.0

                        ShadowShader
                        {
                            anchors.fill: slider
                            source: slider
                            verticalOffset: 4
                            horizontalOffset: 4
                            color: "black"
                            transparentBorder: true
                        }
                    }

                    Label
                    {
                        text: "Strength: " + (radialDropShadow.blurStrength).toFixed(2)
                    }
                }
            }

            Item
            {
                width: 100
                height: 100

                MouseArea
                {
                    id: itemArea
                    hoverEnabled: true
                    anchors.fill: parent
                }

                ToolTip.visible: itemArea.containsMouse
                ToolTip.text: qsTr("Usage of opacity mask shader. Shadow with maximum blur strength (2).")

                Image
                {
                    id: bug
                    source: "qrc:///Original_bug.png"
                    sourceSize: Qt.size(parent.width, parent.height)
                    smooth: true
                    visible: false
                }

                Image
                {
                    id: mask
                    source: "qrc:///OpacityMask_mask.png"
                    sourceSize: Qt.size(parent.width, parent.height)
                    smooth: true
                    visible: false
                }

                ShadowShader
                {
                    anchors.fill: mask
                    source: mask
                    color: "black"
                    blurStrength: 2
                }

                OpacityMaskShader
                {
                    anchors.fill: bug
                    source: bug
                    maskSource: mask
                }
            }

            Item
            {
                width: comboBox.width + 2
                height: comboBox.height + 2

                MouseArea
                {
                    id: itemArea2
                    hoverEnabled: true
                    anchors.fill: parent
                }

                ToolTip.visible: itemArea2.containsMouse
                ToolTip.text: qsTr("ComboBox with black shadow on layer effect, vertical/horizontal offset 2, blur strength 0.25, samples 20, color red and transprarent border.")

                ComboBox
                {
                    id: comboBox
                    model: 10

                    popup: Popup
                    {
                        y: 32
                        width: 255
                        implicitHeight: Math.min(Math.max(comboBox.height, listView.contentHeight), 122) + 2
                        padding: 1

                        contentItem: ListView
                        {
                            id: listView
                            clip: true
                            model: comboBox.popup.visible ? comboBox.delegateModel : null
                        }

                        background: Rectangle
                        {
                            border.width: 1
                            radius: 3

                            layer.enabled: true
                            layer.effect: ShadowShader
                            {
                                blurStrength: 0.5
                                samples: 20
                                verticalOffset: 2
                                horizontalOffset: 2
                                color: "red"
                                transparentBorder: true
                            }
                        }
                    }

                    background: Rectangle
                    {
                        implicitWidth: 122
                        border.width: 1
                        border.color: "grey"
                        radius: 3

                        layer.enabled: true
                        layer.effect: ShadowShader
                        {
                            blurStrength: 0.5
                            samples: 20
                            verticalOffset: 2
                            horizontalOffset: 2
                            color: "red"
                            transparentBorder: true
                        }
                    }
                }
            }

            Binding
            {
                target: dropShaderDuck
                property: "verticalOffset"
                value: slider.value
            }

            Binding
            {
                target: dropShaderDuck
                property: "horizontalOffset"
                value: slider.value
            }

            Binding
            {
                target: directionalDropShadowLogo
                property: "verticalOffset"
                value: slider.value / 4.0
            }

            Binding
            {
                target: directionalDropShadowLogo
                property: "horizontalOffset"
                value: slider.value / 4.0
            }

            Binding
            {
                target: radialDropShadow
                property: "blurStrength"
                value: slider.value / 4.0
            }

            Binding
            {
                target: directionalDropShadow
                property: "blurStrength"
                value: slider.value / 4.0
            }

            Binding
            {
                target: directionalDropShadowLogo
                property: "blurStrength"
                value: slider.value / 8.0
            }
        }
    }
}
