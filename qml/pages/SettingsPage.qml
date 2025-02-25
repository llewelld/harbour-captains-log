/*
 * This file is part of Captain's Log.
 * SPDX-FileCopyrightText: 2020 Gabriel Berkigt
 * SPDX-FileCopyrightText: 2020-2023 Mirian Margiani
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0

Page {
    id: root
    allowedOrientations: Orientation.All

    onStatusChanged: {
        if(status == PageStatus.Deactivating) {
            if (protectionSwitch.checked && config.protectionCode !== "-1") {
                // if protection is switched on AND a protection code is set - save!
                config.useCodeProtection = true

                // if the code was just set, make sure the app knows it's unlocked
                appWindow.unlocked = true
            } else {
                // if not checked or code not set rollback all details
                config.useCodeProtection = false
                config.protectionCode = "-1"
            }
        }
    }

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator { flickable: flick }

        Column {
            id: column
            spacing: Theme.paddingLarge
            width: parent.width

            PageHeader {
                title: qsTr("Settings")
            }

            SectionHeader {
                text: qsTr("Security")
            }

            TextSwitch {
                id: protectionSwitch
                text: qsTr("activate code protection")
                checked: config.useCodeProtection
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: config.protectionCode === "-1" ? qsTr("Set Code") : qsTr("Change Code")
                visible: protectionSwitch.checked
                onClicked: pageStack.push(Qt.resolvedUrl("ChangePinPage.qml"), {
                    expectedCode: config.protectionCode === "-1" ? "" : config.protectionCode,
                    settingsPage: root
                })
            }

            SectionHeader {
                text: qsTr("Export features")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Export data")
                onClicked: pageStack.push(Qt.resolvedUrl("ExportPage.qml"))
            }
        }
    }
}
