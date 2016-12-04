import QtQuick 2.0
import QtQuick.Controls 2.0

ListView {
	id: konsole
	anchors.fill: parent
	anchors.margins: 2
	spacing: 4
	focus: true

	property bool tee: true
	property int linewidth: 80

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
		list.unshift({
			"text": s,
			"color": "#4DD0E5"
		})
		if (tee)
			console.debug(s)
		model = list
	}

	function info() {
		var s = listStringfy(arguments)
		var list = model
		list.unshift({
			"text": s,
			"color": "#6AFB92"
		})
		if (tee)
			console.info(s)
		model = list
	}

	function log() {
		var s = listStringfy(arguments)
		var list = model
		list.unshift({
			"text": s,
			"color": "#FF8040"
		})
		if (tee)
			console.log(s)
		model = list
	}

	function warn() {
		var s = listStringfy(arguments)
		var list = model
		list.unshift({
			"text": s,
			"color": "#E6624E"
		})
		if (tee)
			console.warn(s)
		model = list
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
		var r = (o === undefined)?"undefined":
			(o === null)?"null":o.toString()
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
		var rr = []
		for (j in r) {
			var rj = r[j]
			rr.push(rj.slice(0, linewidth))
			rj = rj.slice(linewidth)
			linewidth += (i/*+3*/)*2
			while (rj.length > 0) {
				rr.push(ri + " " + rj.slice(0, linewidth))
				rj = rj.slice(linewidth)
			}
		}
		rr = rr.join("\n")
		return rr
	}
}
