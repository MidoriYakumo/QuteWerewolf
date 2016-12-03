import QtQuick 2.0
import QtQuick.Controls 2.0

ListView {
	id: konsole
	anchors.fill: parent
	anchors.margins: 2
	spacing: 4
	focus: true

	property bool tee: true

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

	function debug() {
		var s = listStringfy(arguments)
		var list = model
		list.push({
			"text": s,
			"color": "#4DD0E5"
		})
		if (tee)
			console.debug(s)
		var onBottom = contentY + height >= contentHeight
		var cy = contentY
		model = list
		if (onBottom)
			positionViewAtEnd()
		else
			contentY = cy
	}

	function info() {
		var s = listStringfy(arguments)
		var list = model
		list.push({
			"text": s,
			"color": "#6AFB92"
		})
		if (tee)
			console.info(s)
		var onBottom = contentY + height >= contentHeight
		var cy = contentY
		model = list
		if (onBottom)
			positionViewAtEnd()
		else
			contentY = cy
	}

	function log() {
		var s = listStringfy(arguments)
		var list = model
		list.push({
			"text": s,
			"color": "#FF8040"
		})
		if (tee)
			console.log(s)
		var onBottom = contentY + height >= contentHeight
		var cy = contentY
		model = list
		if (onBottom)
			positionViewAtEnd()
		else
			contentY = cy
	}

	function warn() {
		var s = listStringfy(arguments)
		var list = model
		list.push({
			"text": s,
			"color": "#E6624E"
		})
		if (tee)
			console.warn(s)
		var onBottom = contentY + height >= contentHeight
		var cy = contentY
		model = list
		if (onBottom)
			positionViewAtEnd()
		else
			contentY = cy
	}

	function listStringfy(list) {
		// args.map( (o) => {stringfy(o, 0)})
		var r = []
		for (var i in list) {
			r.push(stringfy(list[i], 0))
		}
		return r.join(' ')
	}

	function stringfy(o, i){
		var r = o.toString()
		var ri = ""
		for (var j=0;j<i;j++) ri += "  "
		if (r === "[object Object]") {
			var empty = true
			r = "{"
			for (var p in o) {
				r += "\n" + ri + "  " + p + ":" + stringfy(o[p], i+1)
				empty = false
			}
			if (!empty)
				r += "\n" + ri
			r += "}"
		}

		r = r.split("\n")
		var lineWidth = 40
		var rr = []
		for (j in r) {
			var rj = r[j]
			rr.push(rj.slice(0, lineWidth))
			rj = rj.slice(lineWidth)
			lineWidth += (i/*+3*/)*2
			while (rj.length > 0) {
				rr.push(ri + " " + rj.slice(0, lineWidth))
				rj = rj.slice(lineWidth)
			}
		}
		rr = rr.join("\n")
		return rr
	}
}
