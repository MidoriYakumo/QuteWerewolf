import QtQuick 2.0
import Qt.WebSockets 1.0
import QtQuick.LocalStorage 2.0

import "config.js" as Config

Item {
	id: client

	property var konsole: console

	property bool online: false

	WebSocket {
		id: ws

		active: true
		url: "ws://%1:%2"
			.arg(Config.host)
			.arg(Config.port)

		property bool retryEnabled: true
		property Timer retryTimer: Timer {
			running: ws.retryEnabled && !ws.active
			repeat: false
			interval: Config.retryDelay

			onTriggered: {
				ws.active = true
			}
		}

		onStatusChanged: {
			switch (status) {
			case WebSocket.Connecting:
				konsole.log("Connecting")
				break
			case WebSocket.Open:
				konsole.log("Connected")
				client.online = true
				player.ws = ws
				player.start()
				break
			case WebSocket.Closing:
				konsole.log("Closing")
				break
			default:
				konsole.log(status, ":", errorString)
				active = false
				break
			}
		}

		onTextMessageReceived: {
			konsole.log(message)
//			try {
				var msg = JSON.parse(message)
				player.process(msg)
//			} catch (e) {

//			}
		}
	}

	Player {
		id: player
	}

	Component.onCompleted: {
		konsole.log("Client inited")
	}
}
