import QtQuick 2.0
import Qt.WebSockets 1.0

Item {
	id: player

	property Socket socket
	property string message

	Connections {
		target: socket
		onReceived: process(obj)
	}

	state: "quited"

	states: [
		State {
			name: "started"
		},
		State {
			name: "quited"
		},
		State {
			name: "outdoor"
		}
	]

	property bool toLogin: false
	onToLoginChanged: {
		if (toLogin) {
			konsole.log("toLogin")
			socket.send({"username": "Midori"})
			toLogin = false
		}
	}

	function process(obj) {
		for (var i in obj)
			player[i] = obj[i]
		if (message) {
			konsole.info(message)
			message = ""
		}
	}

	function start() {
		state = "started"
	}
}
