import QtQuick 2.0
import QtQml.StateMachine 1.0
import Qt.WebSockets 1.0

StateMachine {
	id: player

	property WebSocket ws

	running: false
	initialState: outdoor


	FinalState {
		id: offline
	}

	State {
		id: outdoor
		onEntered: {
			var msg = {"state": "outdoor", "toLogin": true}
			ws.sendTextMessage(JSON.stringify(msg))
		}
	}

	Component.onCompleted: {
		ws.statusChanged = function(message){
			konsole.log(message)
		}
	}

	onFinished: {
		destroy()
	}
}
