import QtQuick 2.7

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
		client.konsole = konsole
	}
}
