import QtQuick 2.0
import Qt.WebSockets 1.0
import QtQuick.LocalStorage 2.0

import "global.js" as Global
import "config.js" as Config
import "game.js" as Game

Item {
	id: server

	WebSocketServer {
		id: wsever

		accept: true
		host: Config.host
		port: Config.port
		listen: true
		name: "werewolf"

		onClientConnected: {
			if (Game.players.length >= Config.maxPlayerCnt) {
				rejectSocket.ws = webSocket
				rejectSocket.reject("max cnt")
				return
			}

			var player = playerComp.createObject(server, {ws: webSocket})
			Game.players.push(player)
			player.start()
		}
	}

	Component {
		id: playerComp

		Player {

		}
	}

	Socket {
		id: rejectSocket
	}

	Component.onCompleted: {
		Global.konsole.log("Server inited.")
	}
}
