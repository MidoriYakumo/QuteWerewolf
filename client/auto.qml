import QtQuick 2.7

import "global.js" as Global

Item {
	width: 800
	height: 600

	Konsole {
		id: konsole
	}

	TestClient {
		id: client
	}

	Component.onCompleted: {
		Global.konsole = konsole
	}
}
