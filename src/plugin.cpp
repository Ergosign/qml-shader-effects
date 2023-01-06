#include <QQmlEngine>
#include <QtQml/QQmlExtensionPlugin>

class QmlShaderEffectsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char* uri) override
    {
        qmlRegisterModule(uri, 1, 0);
    }
};

#include "plugin.moc"
