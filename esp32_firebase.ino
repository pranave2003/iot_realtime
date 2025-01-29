#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>

// WiFi credentials
#define WIFI_SSID "YOUR_WIFI_SSID"
#define WIFI_PASSWORD "YOUR_WIFI_PASSWORD"

// Firebase credentials
#define API_KEY "AIzaSyBameue9KKh7BO7TkOK_jsksUKEH-lff_U"
#define DATABASE_URL "https://demo1-282df-default-rtdb.asia-southeast1.firebasedatabase.app"

// Define pins
#define LED_PIN 2    // Built-in LED
#define LED_PIN2 4   // External LED
#define FAN_PIN 5    // Fan control pin

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

void setup() {
  Serial.begin(115200);
  delay(1000); // Give time for serial to initialize

  // Initialize pins
  pinMode(LED_PIN, OUTPUT);
  pinMode(LED_PIN2, OUTPUT);
  pinMode(FAN_PIN, OUTPUT);
  
  // Connect to WiFi
  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(1000);
  
  Serial.println("\nConnecting to WiFi...");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  
  int attempts = 0;
  while (WiFi.status() != WL_CONNECTED && attempts < 20) {
    delay(500);
    Serial.print(".");
    attempts++;
  }
  
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("\nWiFi connection failed!");
    ESP.restart();
    return;
  }
  
  Serial.println("\nConnected to WiFi!");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());

  // Configure Firebase
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  
  Serial.println("Initializing Firebase...");
  Firebase.begin(&config, &auth);
  
  // Optional: Reduce Firebase response timeout
  fbdo.setResponseTime(10000); // 10 seconds
  
  Serial.println("Setup complete!");
}

void loop() {
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("WiFi disconnected, restarting...");
    ESP.restart();
    return;
  }

  if (Firebase.ready()) {
    // Check LED status
    if (Firebase.RTDB.getBool(&fbdo, "/led")) {
      bool ledStatus = fbdo.boolData();
      digitalWrite(LED_PIN, ledStatus);
      digitalWrite(LED_PIN2, ledStatus);
      Serial.println("LED: " + String(ledStatus ? "ON" : "OFF"));
    }

    // Check Fan status
    if (Firebase.RTDB.getBool(&fbdo, "/fan")) {
      bool fanStatus = fbdo.boolData();
      digitalWrite(FAN_PIN, fanStatus);
      Serial.println("Fan: " + String(fanStatus ? "ON" : "OFF"));
    }
  }
  
  delay(1000); // Increased delay to reduce frequent checks
} 