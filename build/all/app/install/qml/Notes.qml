import QtQuick 2.12
import Ubuntu.Components 1.3


Page {
    id: NotesPage
    title: "Notes"

    Item {
        width: 400
        height: 400

        ListModel {
            id: noteModel
            ListElement { text: "Note 1" }
            ListElement { text: "Note 2" }
            ListElement { text: "Note 3" }
        }

        ListView {
            anchors.fill: parent
            model: noteModel
            delegate: Text {
                text: model.text
                width: parent.width
                height: 30
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Button {
            text: "Add Note"
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 20
            }
            onClicked: {
                noteModel.append({ text: "New Note" })
            }
        }

        Button {
            text: "Delete Note"
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 60
            }
            onClicked: {
                if (noteModel.count > 0) {
                    noteModel.remove(noteModel.count - 1)
                }
            }
        }
    }
}