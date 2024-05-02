/*
 * Copyright (C) 2024  Louis Voisembert
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * qttest is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Ubuntu.Components 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'qttest.cranesuciter'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property real elapsedSeconds: 0

    Page {
        id: mainPage
        anchors.fill: parent
        header: PageHeader {
            id: header
            title: i18n.tr('GymRat')

            Row {
                Button {
                    text: "Main Page"
                    onClicked: mainPage.StackView.push(Qt.resolvedUrl("Main.qml"))
                }
                Button {
                    text: "Notes"
                    onClicked: mainPage.StackView.push(Qt.resolvedUrl("Notes.qml"))
                }
            }

            StyleHints {
                foregroundColor: UbuntuColors.orange
                backgroundColor: UbuntuColors.porcelain
                dividerColor: UbuntuColors.slate
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "black"
        }

        Timer {
            id: stopwatchTimer
            interval: 10 // 0.1 second
            running: false
            repeat: true
            onTriggered: {
                elapsedSeconds += 0.01
            }
        }

        Rectangle {

            id: circleBackground
            width: units.gu(25) // adjust to your needs
            height: width // to make it a circle
            color: "grey" // adjust to your needs
            radius: width / 2
            anchors.centerIn: parent

        }

        Label {
            //anchors {
            //    top: header.bottom
            //    left: parent.left
            //    right: parent.right
            //    bottom: parent.bottom
            //}
            anchors.centerIn: circleBackground
            font.pixelSize: units.gu(5)
            text: {
                var minutes = Math.floor(root.elapsedSeconds / 60);
                var seconds = Math.floor(root.elapsedSeconds % 60);
                var centiseconds = Math.floor((root.elapsedSeconds % 1) * 100);
                return minutes.toString().padStart(2, '0') + ":" + 
                    seconds.toString().padStart(2, '0') + ":" + 
                    centiseconds.toString().padStart(2, '0');
            }

            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
        }

        Button {
            text: stopwatchTimer.running ? i18n.tr('Stop') : i18n.tr('Start')
            color: stopwatchTimer.running ? UbuntuColors.red : UbuntuColors.green
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                margins: units.gu(2)
            }
            onClicked: {
                stopwatchTimer.running = !stopwatchTimer.running
                if (!stopwatchTimer.running) {
                    stopwatchTimer.stop()
                } else {
                    stopwatchTimer.start()
                }
            }
        }

        Button {
            id: resetButton

            anchors {
                bottom: parent.bottom
                horizontalCenter: units.gu(22)
                margins: units.gu(2)
            }

            text: i18n.tr('Reset')
            color: UbuntuColors.green
            visible: !stopwatchTimer.running && root.elapsedSeconds > 0

            onClicked: {
                root.elapsedSeconds = 0
            }
        }
    }
}
