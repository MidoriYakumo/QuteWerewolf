.pragma library // shared states

var konsole = console

var db = ({})

function onPlayerOutDoor(ws) {
	ws.sendTextMessage(arguments.callee.name)
}
