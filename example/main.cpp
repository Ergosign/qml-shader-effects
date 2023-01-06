#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;
    view.setWidth(480);
    view.setHeight(840);
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    view.engine()->addImportPath(":/.");

    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.show();

    return app.exec();
}
