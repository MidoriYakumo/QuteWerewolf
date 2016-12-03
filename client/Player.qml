import QtQuick 2.0
import Qt.WebSockets 1.0

Item {
	id: player

	property WebSocket ws

	state: "started"

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
			var msg = {"username": "Midori"}
			ws.sendTextMessage(JSON.stringify(msg))
			toLogin = false
		}
	}

	function process(msg) {
		konsole.log(msg)
		for (var i in msg)
			player[i] = msg[i]
	}

	function start() {
		state = "started"
	}
}
