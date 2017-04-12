import VPlay 2.0
import QtQuick 2.0

GameWindow {
  id: gameWindow

  // you get free licenseKeys as a V-Play customer or in your V-Play Trial
  // with a licenseKey, you get the best development experience:
  //  * No watermark shown
  //  * No license reminder every couple of minutes
  //  * No fading V-Play logo
  // you can generate one from https://v-play.net/developers/license/, then enter it below:
  //licenseKey: "<generate one from https://v-play.net/developers/license/>"

  activeScene: scene

  // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
  // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
  // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
  screenWidth: 320
  screenHeight: 480

  EntityManager {
    id: entityManager
  }

  Scene {
    id: scene
    sceneAlignmentY: "bottom"
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 320
    height: 480

    property int playerinitx: 160
    property int pipe1initx: 40
    property int pipe2initx: 280

    Image {
      id: bg
      source: "../assets/bg.png"
      anchors.horizontalCenter: scene.horizontalCenter
      anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    Pipe {
      id: pipe1
      x: 40
      y: 30+Math.random()*200
    }

    Pipe {
      id: pipe2
      x: 280
      y: 30+Math.random()*200
    }


    Ground {
      anchors.horizontalCenter: scene.horizontalCenter
      anchors.bottom: scene.gameWindowAnchorItem.bottom
    }

    Player {
      id: player
      x: 160
      y: 180
    }

    PhysicsWorld {
      debugDrawVisible: true // set this to false to hide the physics overlay
      gravity.y: scene.gameState != "wait" ? 27 : 0 // 9.81 would be earth-like gravity, so this one will be pretty strong
    }

    MouseArea {
      anchors.fill: scene.gameWindowAnchorItem
      onPressed: {
        if(scene.gameState == "wait") {
          scene.startGame()
          player.push()
        } else if(scene.gameState == "play") {
          player.push()
        } else if(scene.gameState == "gameOver") {
          scene.reset()
        }
      }
    }

    property string gameState: "wait"

    function startGame() {
      scene.gameState = "play"
    }

    function stopGame() {
      scene.gameState = "gameOver"
    }

    function reset() {
      scene.gameState = "wait"
      pipe1.x = pipe1initx
      pipe1.y = 30+Math.random()*200
      pipe2.x = pipe2initx
      pipe2.y = 30+Math.random()*200
      player.x = playerinitx
      player.y = 180
      scene.score = 0
    }

    property int score: 0

    Text {
      text: scene.score
      color: "white"
      anchors.horizontalCenter: scene.horizontalCenter
      y: 30
      font.pixelSize: 30
    }

  }
}

