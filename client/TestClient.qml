import QtQuick 2.0
import Qt.WebSockets 1.0
import QtQuick.LocalStorage 2.0

import "global.js" as Global
import "config.js" as Config

Item {
	id: client

	property bool online: false

	Socket {
		id: socket

		ws: WebSocket {
			active: false
			url: "ws://%1:%2"
				.arg(Config.host)
				.arg(Config.port)

			onStatusChanged: {
				switch (status) {
				case WebSocket.Connecting:
					konsole.log("Connecting")
					break
				case WebSocket.Open:
					konsole.log("Connected")
					client.online = true
					player.socket = socket
					player.start()
					break
				case WebSocket.Closing:
					konsole.log("Closing")
					break
				default:
					konsole.log(status, ":", errorString)
					socket.close()
					socket.retryLater(socket.open)
					break
				}
			}
		}
	}

	Player {
		id: player
	}

	Component.onCompleted: {
		Global.konsole.log("Client inited")
		socket.open()
	}
}
