import QtQuick 2.7

Item {
	width: 800
	height: 600

	Konsole {
		id: konsole
	}

	Server {
		id: server
	}

	Component.onCompleted: {
		server.konsole = konsole
	}
}
