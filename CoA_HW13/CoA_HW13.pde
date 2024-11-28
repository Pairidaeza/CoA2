int viewMode = 0; // 0: bird's eye view, 1: first-person view
float angle = 0;  // 박스의 회전용 변수

// 물체 데이터
PVector spherePos, boxPos; // PVector: 벡터의 구성요소를 저장하는 class. 이 경우 위치에 해당
float sphereSpeed = 2, boxSpeed = 1.5;

int boxCount = 5; // 박스 개수
PVector[] boxPositions = new PVector[boxCount]; // 박스 위치 배열
PVector[] boxSpeeds = new PVector[boxCount];   // 박스 속도 배열

float yaw = 0;   // 좌우 회전 (yaw)
float pitch = 0; // 상하 회전 (pitch)
float sensitivity = 0.5; // 마우스 회전 민감도

void setup() {
  size(800, 800, P3D);
  
  // 구 위치 초기화
  // (0,0,0)에서 시작한다.
  spherePos = new PVector(0, 0, 0);

  // 박스 위치, 속도 초기화
  // 박스는 각각 무작위의 좌표, 속도를 가진다.
  for (int i = 0; i < boxCount; i++) {
    boxPositions[i] = new PVector(random(-300, 300), random(-300, 300), random(-300, 300));
    boxSpeeds[i] = new PVector(random(-2, 2), random(-2, 2), random(-2, 2));
  }
}

void draw() {
  background(50);
  
  // viewMode == 0 -> Bird's eye view
  if (viewMode == 0) {
    camera(400, -400, 400, 0, 0, 0, 0, 1, 0);
  }
  
  // viewMode == 1 -> First-person view   
  // 1인칭 시점일 때 마우스의 움직임에 따라서 카메라의 위치와 카메라가 바라보는 방향을 변경한다
  else if (viewMode == 1) {
    float camX = spherePos.x + cos(radians(yaw)) * cos(radians(pitch)) * 200;
    float camY = spherePos.y + sin(radians(pitch)) * 200;
    float camZ = spherePos.z + sin(radians(yaw)) * cos(radians(pitch)) * 200;

    float lookX = spherePos.x + cos(radians(yaw)) * cos(radians(pitch));
    float lookY = spherePos.y + sin(radians(pitch));
    float lookZ = spherePos.z + sin(radians(yaw)) * cos(radians(pitch));

    camera(camX, camY, camZ, lookX, lookY, lookZ, 0, 1, 0);
  }
  
  // 빛과 재질 설정
  lights();
  noStroke();

  // 구 그리기
  // viewMode == 0, 즉 Bird's eye view인 경우에만 구를 그린다.
  // viewMode == 1, 즉 1인칭 시점일 때에는 구를 그리지 않음
  if (viewMode == 0) {
    pushMatrix();
    translate(spherePos.x, spherePos.y, spherePos.z);
    fill(150, 50, 200);
    sphere(50);
    popMatrix();
  }
  
  
  // 박스 그리기 + 회전
  angle += 0.05;
  for (int i = 0; i < boxCount; i++) {
    pushMatrix();
    translate(boxPositions[i].x, boxPositions[i].y, boxPositions[i].z);
    rotateX(angle * 0.1 + i); // x축 기준으로 박스 회전
    rotateY(angle * 0.1 + i); // y축 기준으로 박스 회전
    fill(50 + i * 40, 200 - i * 30, 100 + i * 20);
    box(70);
    popMatrix();

    // 박스 이동
    boxPositions[i].add(boxSpeeds[i]); // add()는 PVector class에 내장된 함수이다. 말 그대로 더하는 기능

    // 경계에 충돌할 경우 반대 방향으로 튕김
    if (boxPositions[i].x > width / 2 || boxPositions[i].x < -width / 2) boxSpeeds[i].x = -boxSpeeds[i].x;
    if (boxPositions[i].y > height / 2 || boxPositions[i].y < -height / 2) boxSpeeds[i].y = -boxSpeeds[i].y;
    if (boxPositions[i].z > 300 || boxPositions[i].z < -300) boxSpeeds[i].z = -boxSpeeds[i].z;
  }

  // 구 이동
  spherePos.x += sphereSpeed;
  
  // 경계에 충돌할 경우 반대 방향으로 튕김
  if (spherePos.x > width / 2 || spherePos.x < -width / 2) sphereSpeed = -sphereSpeed;
}

// 마우스 이동량을 기반으로 yaw와 pitch 업데이트
void mouseDragged() {
  if (viewMode == 1) { // 1인칭 시점인 경우
    yaw += (mouseX - pmouseX) * sensitivity;
    pitch -= (mouseY - pmouseY) * sensitivity;

    // pitch 제한 (상하 회전 각도 제한)
    pitch = constrain(pitch, -89, 89); // pitch의 값을 -89 이상 89 이하로 제한한다.
  }
}

void keyPressed() {
  if (key == ' ') {
    viewMode = (viewMode + 1) % 2; // 스페이스바를 눌러서 시점 전환
  }
}
