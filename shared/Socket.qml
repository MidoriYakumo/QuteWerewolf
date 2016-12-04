import QtQuick 2.0
import Qt.WebSockets 1.0

import "global.js" as Global
import "config.js" as Config

//import "i18n.js" as I18n

Item {
	id: socket

	property WebSocket ws
	readonly property bool active: ws && ws.active
	property var receivedHandler
	property bool retryEnabled: true
	property var retryAction: open
	signal received(var obj)
	signal closed()

	Timer {
		id: retryTimer

		repeat: false
		interval: Config.retryDelay

		onTriggered: {
			if (retryAction)
				retryAction()
		}
	}

	function send(obj) {
		ws.sendTextMessage(JSON.stringify(obj))
	}

	function reject(reason) {
		send({
			"state": "quited",
			"message": "You are rejected" + // I18n
				(reason?" because %1.".arg(reason):".")
		})
		close()
	}

	function wsReceived(message){
		try {
			var obj = JSON.parse(message)
			if (!receivedHandler || receivedHandler(obj))
				received(obj)
		} catch (e) {
			Global.konsole.warn(e, "when receiving '%1'.".arg(message))
		}
	}

	function open() {
		if (ws)
			ws.active = true
	}

	function close() {
		if (ws)
			ws.active = false
		//closed()
		//destroy()
	}

	function retryLater(action) {
		if (retryEnabled) {
			if (action)
				retryAction = action
			retryTimer.start()
		}
	}

	Connections {
		enabled : !ws
		ignoreUnknownSignals : true
		target : ws
		onTextMessageReceived: socket.wsReceived(message)
		onStatusChanged: {
			switch (status) {
			case WebSocket.Closing:
				close()
				break
			case WebSocket.Closed:
				closed()
				break
			}
		}
	}
}
