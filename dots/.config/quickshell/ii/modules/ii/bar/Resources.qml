import qs.modules.common
import qs.services
import QtQuick
import QtQuick.Layouts

MouseArea {
    id: root
    property bool borderless: Config.options.bar.borderless
    property bool alwaysShowAllResources: false
    readonly property real highestUsagePercentage: Math.max(
        ResourceUsage.memoryUsedPercentage,
        ResourceUsage.swapUsedPercentage,
        ResourceUsage.cpuUsage,
        ResourceUsage.diskUsedPercentage
    )
    readonly property bool hasWarning: (
        ResourceUsage.memoryUsedPercentage * 100 >= Config.options.bar.resources.memoryWarningThreshold ||
        ResourceUsage.swapUsedPercentage * 100 >= Config.options.bar.resources.swapWarningThreshold ||
        ResourceUsage.cpuUsage * 100 >= Config.options.bar.resources.cpuWarningThreshold ||
        ResourceUsage.diskUsedPercentage * 100 >= 90
    )
    implicitWidth: rowLayout.implicitWidth + rowLayout.anchors.leftMargin + rowLayout.anchors.rightMargin
    implicitHeight: Appearance.sizes.barHeight
    hoverEnabled: !Config.options.bar.tooltips.clickToShow

    RowLayout {
        id: rowLayout

        spacing: 0
        anchors.fill: parent
        anchors.leftMargin: 4
        anchors.rightMargin: 4

        Resource {
            iconName: "speed"
            percentage: root.highestUsagePercentage
            shown: true
            showPercentage: false
            forceWarning: root.hasWarning
        }
    }

    ResourcesPopup {
        hoverTarget: root
    }
}
