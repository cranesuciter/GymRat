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
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Ubuntu.Components 1.3

ApplicationWindow {
    visible: true
    width: units.gu(45)
    height: units.gu(75)
    id: mainWindow

    property real elapsedSeconds: 0

    SwipeView {
        id: view
        anchors.fill: parent
        currentIndex: 1
        
        Item {

            Rectangle
            {
                anchors.fill: parent
                color: "black"
            }

            Label {
                text: "StopWatch"
                font.pixelSize: units.gu(5)
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: units.gu(2)
                color: "white"
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
                width: units.gu(25)
                height: width
                color: "grey"
                radius: width / 2
                anchors.centerIn: parent

            }

            Label {
                anchors.centerIn: circleBackground
                font.pixelSize: units.gu(5)
                text: {
                    var minutes = Math.floor(mainWindow.elapsedSeconds / 60);
                    var seconds = Math.floor(mainWindow.elapsedSeconds % 60);
                    var centiseconds = Math.floor((mainWindow.elapsedSeconds % 1) * 100);
                    return minutes.toString().padStart(2, '0') + ":" + 
                        seconds.toString().padStart(2, '0') + ":" + 
                        centiseconds.toString().padStart(2, '0');
                }

                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
            }

            Button {
                id: startStopButton
                text: stopwatchTimer.running ? i18n.tr('Stop') : i18n.tr('Start')
                color: stopwatchTimer.running ? UbuntuColors.red : UbuntuColors.green
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: units.gu(4)
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
                    bottom: startStopButton.top
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: units.gu(2)
                }
                text: i18n.tr('Reset')
                color: UbuntuColors.green
                visible: !stopwatchTimer.running && mainWindow.elapsedSeconds > 0

                onClicked: {
                    mainWindow.elapsedSeconds = 0
                }
            }
        }
        
        Item {

            Rectangle
            {
                anchors.fill: parent
                color: "black"
            }

            Label {
                text: "Notes"
                anchors.centerIn: parent
                color: "white"
            }
        }
        
        Item {
            Rectangle
            {
                anchors.fill: parent
                color: "black"
            }

            Label {
                text: "Music"
                anchors.centerIn: parent
                color: "white"
            }
        }  
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }   
}