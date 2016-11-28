import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
	width: 800
	height: 600

	ListView {
		id: konsole
		anchors.fill: parent
		anchors.margins: 2
		spacing: 4
		focus: true

		model: []
		delegate: Label {
			width: konsole.width
			padding: 8
			text: modelData.text
			background: Rectangle {
				border.width: 1
				border.color: "grey"
				color: modelData.color
				radius: 2
			}
		}

		function debug(s) {
			var list = model
			list.push({
				"text": s,
				"color": "#4DD0E5"
			})
			var onBottom = contentY + height >= contentHeight
			var cy = contentY
			model = list
			if (onBottom)
				positionViewAtEnd()
			else
				contentY = cy
		}

		function info(s) {
			var list = model
			list.push({
				"text": s,
				"color": "#6AFB92"
			})
			var onBottom = contentY + height >= contentHeight
			var cy = contentY
			model = list
			if (onBottom)
				positionViewAtEnd()
			else
				contentY = cy
		}

		function log(s) {
			var list = model
			list.push({
				"text": s,
				"color": "#FF8040"
			})
			var onBottom = contentY + height >= contentHeight
			var cy = contentY
			model = list
			if (onBottom)
				positionViewAtEnd()
			else
				contentY = cy
		}

		function warn(s) {
			var list = model
			list.push({
				"text": s,
				"color": "#E6624E"
			})
			var onBottom = contentY + height >= contentHeight
			var cy = contentY
			model = list
			if (onBottom)
				positionViewAtEnd()
			else
				contentY = cy
		}
	}

	Server {
		id: server
	}

	Component.onCompleted: {
		server.setKonsole(konsole)
	}
}
