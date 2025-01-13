#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>

#define WIFI_SSID "Your_WiFi_SSID"
#define WIFI_PASSWORD "Your_WiFi_Password"
#define FIREBASE_HOST "your-project.firebaseio.com"
#define FIREBASE_AUTH "your-firebase-database-secret"

FirebaseData firebaseData;
String deviceId = "device1";

// Define GPIO pins
const int GPIO_PINS[] = {12, 13, 14};
const int NUM_PINS = 3;

void setup() {
  Serial.begin(115200);
  
  // Initialize GPIO pins
  for (int i = 0; i < NUM_PINS; i++) {
    pinMode(GPIO_PINS[i], OUTPUT);
    digitalWrite(GPIO_PINS[i], LOW);
  }
  
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
}

void loop() {
  // Check main device status
  if (Firebase.getBool(firebaseData, "/devices/" + deviceId + "/status")) {
    bool deviceStatus = firebaseData.boolData();
    digitalWrite(LED_BUILTIN, deviceStatus ? HIGH : LOW);
  }

  // Check GPIO status
  for (int i = 0; i < NUM_PINS; i++) {
    String path = "/devices/" + deviceId + "/gpio/" + String(GPIO_PINS[i]);
    if (Firebase.getBool(firebaseData, path)) {
      bool pinStatus = firebaseData.boolData();
      digitalWrite(GPIO_PINS[i], pinStatus ? HIGH : LOW);
    }
  }
  
  delay(100);
} 