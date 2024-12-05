import processing.net.*;

Client client;
String serverIP = "127.0.0.1";
int serverPort = 12345;
String status = "Disconnected";
String feedback = "Click and drag to send mouse position to server";
boolean isDragging = false;  // 드래그 상태 확인

void setup() {
  size(400, 200);
  client = new Client(this, serverIP, serverPort);
  status = "Connected to server at " + serverIP;
}

void draw() {
  background(100);
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Client Status:", width / 2, height / 3);
  text(status, width / 2, height / 2);
  text(feedback, width / 2, height - 50);
  
  // 마우스 드래그 상태에서 서버로 좌표를 지속적으로 전송
  if (isDragging && client.active()) {
    String mousePos = mouseX + "," + mouseY;  // 마우스 좌표
    client.write(mousePos + "\n");  // 서버로 좌표 전송
  } else if (!client.active()) {
    feedback = "Disconnected from server.";
    isDragging = false;  // 서버가 연결 끊기면 드래그 상태 종료
  }
}

void mousePressed() {
  if (client.active()) {
    isDragging = true;  // 마우스 클릭 시작
    feedback = "Dragging started...";
  } else {
    feedback = "Failed to connect to server.";
  }
}

void mouseReleased() {
  isDragging = false;  // 마우스 클릭 종료
  feedback = "Dragging stopped.";
}
