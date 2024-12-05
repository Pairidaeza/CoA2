import processing.net.*;

Server server;
String message = "Waiting for client message...";
ArrayList<Ellipse> ellipses = new ArrayList<>();  // 원들을 저장하는 리스트

class Ellipse {
  float x, y;
  float alpha;
  
  Ellipse(float x, float y, float alpha) {
    this.x = x;
    this.y = y;
    this.alpha = alpha;
  }
}

void setup() {
  size(400, 200);
  server = new Server(this, 12345);  // 포트 12345에서 서버 실행
}

void draw() {
  background(50);
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Server Status:", width / 2, height / 3);
  text(message, width / 2, height / 2);
  
  Client client = server.available();
  if (client != null) {
    String received = client.readString();
    if (received != null && !received.isEmpty()) {
      // 클라이언트로부터 받은 마우스 좌표 처리
      String[] coords = received.trim().split(",");
      if (coords.length == 2) {
        int x = int(coords[0]);
        int y = int(coords[1]);
        message = "Received mouse position: (" + x + ", " + y + ")";
        
        // 새로운 원 추가 (알파 값은 점차 줄어듬)
        ellipses.add(new Ellipse(x, y, 255));
      }
    }
  }

  // 각 원 그리기 및 alpha 값 감소
  noStroke();
  for (int i = ellipses.size() - 1; i >= 0; i--) {
    Ellipse e = ellipses.get(i);
    fill(255, 0, 0, e.alpha);  // 빨간색, alpha 값으로 투명도 조정
    ellipse(e.x, e.y, 10, 10);
    
    // alpha 값을 감소시켜 원이 점점 투명해지도록
    e.alpha -= 10;
    
    // alpha가 0이 되면 리스트에서 제거
    if (e.alpha <= 0) {
      ellipses.remove(i);
    }
  }
}
