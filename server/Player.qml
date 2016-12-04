import QtQuick 2.0
import QtQml.StateMachine 1.0
import Qt.WebSockets 1.0

import "game.js" as Game

StateMachine {
	id: player

	running: false
	initialState: outdoor

	property alias ws: socket.ws
	property string username

	Socket {
		id: socket

		onClosed: {
			player.stop()
		}
	}

	State {
		id: outdoor
		onEntered: {
			socket.receivedHandler = function(obj) {
				username = obj.username

				if (!username){
					socket.send({"toLogin": true, "message": "bad username"})
					return
				}

				if (Game.players[username]) {
					socket.send({"toLogin": true, "message": "username occupied"})
					return
				}

				Game.players[username] = player
				loginSucceeded.invoke()
			}
			socket.send({"state": "outdoor", "toLogin": true})
		}
		SignalTransition {
			id: loginSucceeded
			targetState: ondesk
		}
	}

	State {
		id: ondesk
		onEntered: {
			konsole.log("%1 is on desk".arg(username))
		}
	}

	onStopped: {
		konsole.log("onStopped")
		delete(Game.players[username])
		destroy()
	}
}
