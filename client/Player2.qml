import QtQuick 2.0
import QtQml.StateMachine 1.0
import Qt.WebSockets 1.0

StateMachine {
	id: player

	property WebSocket ws
	property var stateMap: ({})

	running: false
	initialState: _started

	State {
		id: _started
	}

	FinalState {
		id: quited
	}

	State {
		id: outdoor
		objectName: "outdoor"
		onEntered: {
			konsole.log(123)
		}
	}

	signal transitionSignal()

	SignalTransition {
		id: transition
		signal: transitionSignal
		onTriggered: {
			konsole.log("triggered")
		}
	}

	function process(msg) {
		if (msg.state) {
			var targetState = stateMap[msg.state]
			if (targetState) {
				konsole.log(_started, initialState.active)
				transition.targetState = targetState
				transition.invoke()
				konsole.log(transition.signal, outdoor.active)
			}
		}
	}

	function registerStates(){
		stateMap = ({})
		for (var i in children) {
			var p = children[i]
			if (p.objectName)
				stateMap[p.objectName] = p
		}
	}

	onFinished: {
		destroy()
	}

	onStarted: {
		konsole.log(transition.signal, initialState, _started, initialState.active)
	}

	Component.onCompleted: {
		registerStates()
	}
}
