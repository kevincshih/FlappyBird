import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: pipe
  entityType: "pipe"

  height: 90
  width: 1

  Image {
    id: lowerPipe
    source: "../assets/pipe.png"
    anchors.top: pipe.bottom
    anchors.horizontalCenter: pipe.horizontalCenter
  }

  Image {
    id: upperPipe
    source: "../assets/pipe.png"
    mirror: true
    rotation: 180
    anchors.bottom: pipe.top
    anchors.horizontalCenter: pipe.horizontalCenter
  }

  MovementAnimation {
    id: movement
    target: pipe
    property: "x"
    minPropertyValue: -80
    maxPropertyValue: 400
    velocity: -player.velocity
    running: scene.gameState == "play"
    onLimitReached: {
      if(velocity>0){
          pipe.x=-80
      }
      else{
          pipe.x=400
      }
      pipe.y = 30+Math.random()*200
    }
  }

  BoxCollider {
    anchors.fill: pipe
    bodyType: Body.Static
    collisionTestingOnlyMode: true
    fixture.onBeginContact: {
      scene.score++
    }
  }

  BoxCollider {
    anchors.fill: lowerPipe
    bodyType: Body.Static
    collisionTestingOnlyMode: true
    fixture.onBeginContact: {
        player.velocity = -player.velocity
    }
  }
  BoxCollider {
    anchors.fill: upperPipe
    bodyType: Body.Static
    collisionTestingOnlyMode: true
    fixture.onBeginContact: {
        player.velocity = -player.velocity
    }
  }

}
