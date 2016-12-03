import QtQuick 2.0
import Qt.WebSockets 1.0
import QtQuick.LocalStorage 2.0

import "config.js" as Config

Item {

	property var konsole: console

	WebSocketServer {
		id: ws

		accept: true
		host: Config.host
		port: Config.port
		listen: true
		name: "werewolf"

		onClientConnected: {
			konsole.log(webSocket.url, "connected.")
		}
	}

	Component.onCompleted: {
		konsole.log("Server inited.")
	}
}
