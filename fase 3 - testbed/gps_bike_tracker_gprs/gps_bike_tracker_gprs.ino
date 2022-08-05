#include <TinyGPSPlus.h>
#include <SoftwareSerial.h>
#include "SIM800L.h"

#define POSITION_UPDATE_INTERVAL    5000
#define TIMESTAMP_LEN               25

#define GPS_BAUD_RATE               9600
#define GPS_TX_PIN                  3
#define GPS_RX_PIN                  8  

#define SIM_BAUD_RATE               9600
#define SIM_TX_PIN                  11
#define SIM_RX_PIN                  10
#define SIM_RST_PIN                 6        

#define UUID                        5fb850ee-76db-4eb9-b20c-7c983e8ff73a                          

const char APN[] = "timbrasil.br";
const char URL[] = "http://201.43.62.129:3002/resources/5fb850ee-76db-4eb9-b20c-7c983e8ff73a/data";
const char CONTENT_TYPE[] = "application/json";

TinyGPSPlus gps;
SIM800L* sim800l;
SoftwareSerial gpsSerial(GPS_RX_PIN, GPS_TX_PIN);
SoftwareSerial *simSerial = new SoftwareSerial(SIM_RX_PIN, SIM_TX_PIN);
unsigned long positionLastSentAt = 0;
unsigned int numberOfSends = 0;        

void setupModule() {
    // Wait until the module is ready to accept AT commands
  while(!sim800l -> isReady()) {
    Serial.println(F("Problem to initialize AT command, retry in 1 sec"));
    delay(1000);
  }
  
  Serial.println(F("Setup Complete!"));

  // Wait for the GSM signal
  uint8_t signal = sim800l -> getSignal();
  while(signal <= 0) {
    delay(1000);
    signal = sim800l -> getSignal();
  }
  Serial.print(F("Signal OK (strenght: "));
  Serial.print(signal);
  Serial.println(F(")"));
  delay(1000);

  // setPinCode(const char *pin);
  // Wait for operator network registration (national or roaming network)
  NetworkRegistration network = sim800l -> getRegistrationStatus();
  while(network != REGISTERED_HOME && network != REGISTERED_ROAMING) {
    delay(1000);
    network = sim800l -> getRegistrationStatus();
  }
  Serial.println(F("Network registration OK"));
  delay(1000);

  // Setup APN for GPRS configuration
  bool success = sim800l -> setupGPRS(APN, "tim", "tim");
  while(!success) {
   success = sim800l -> setupGPRS(APN);
    delay(5000);  }  Serial.println(F("GPRS config OK"));

  // Establish GPRS connectivity (5 trials)
  bool connected = false;
  for (uint8_t i = 0; i < 5 && !connected; i++) {
      connected = sim800l -> connectGPRS();
      if (!connected) delay(1000);
  }

  // Check if connected, if not reset the module and setup the config again
  if (connected) {
      Serial.print(F("GPRS connected with IP "));
      Serial.println(sim800l -> getIP());
  }
  else {
      Serial.println(F("GPRS not connected !"));
      Serial.println(F("Reset the module."));
      sim800l -> reset();
      setupModule();
      return;
  }

}

void 
setup()
{
    Serial.begin(9600);
    gpsSerial.begin(GPS_BAUD_RATE);
    simSerial -> begin(SIM_BAUD_RATE);
    sim800l = new SIM800L((Stream *)simSerial, SIM_RST_PIN, 200, 512);
    // sim800l = new SIM800L((Stream *)simSerial, SIM_RST_PIN, 200, 512, (Stream *)&Serial);
    setupModule();
}

void 
loop()
{
    gpsSerial.listen();
    while (gpsSerial.available() > 0) {
        if (gps.encode(gpsSerial.read())) {
            // displayInfo();
            if (gps.location.isValid() && gps.time.isValid() && gps.date.isValid() &&
                millis() - positionLastSentAt > POSITION_UPDATE_INTERVAL) {
                sendPositionUpdate();
                positionLastSentAt = millis();
            }
        }
    }

    // if (millis() > 20000 && gps.charsProcessed() < 10) {
    //     Serial.println("No GPS detected: check wiring.");
    //     while(true);
    // }

    // Comunicação direta com o módulo GPRS
    // while (simSerial -> available())
    //     Serial.write(simSerial -> read());
    // while (Serial.available())
    //     simSerial -> write(Serial.read());
}

void
sendPositionUpdate()
{
    char message[256];
    // 2017-06-14T17:52:25.428Z
    char timestamp[25];
    snprintf(timestamp, TIMESTAMP_LEN, "%d-%02d-%02dT%02d:%02d:%02d.%03dZ", gps.date.year(),
             gps.date.month(), gps.date.day(), gps.time.hour(), gps.time.minute(),
             gps.time.second(), gps.time.centisecond());

    char latitude[10];
    String(gps.location.lat(), 6).toCharArray(latitude, 10);
    char longitude[10];
    String(gps.location.lng(), 6).toCharArray(longitude, 10);
    // FIX: hardcodei o gps porque as strings acima estavam vazias
    snprintf(message, 256, "{ \"data\": {\
\"monitoring\": [\
{\
\"latitude\": -23.57141,\
 \"longitude\": -46.73420,\
 \"numberOfSends\": %d,\
 \"timestamp\": \"%s\"\
}\
]\
}\
}", numberOfSends++, timestamp);

    Serial.println(message);
    // OUVIR A SEGUNDA PORTA SERIAL PRA COMUNICAÇÃO HTTP
    simSerial -> listen();

    if (sim800l -> isConnectedGPRS() == false) {
        // Establish GPRS connectivity (5 trials)
        bool connected = false;
        for (uint8_t i = 0; i < 5 && !connected; i++) {
            connected = sim800l -> connectGPRS();
            if (!connected) delay(200);
        }

        // Check if connected, if not reset the module and setup the config again
        if (connected) {
            Serial.print(F("GPRS connected with IP "));
            Serial.println(sim800l -> getIP());
        }
        else {
            Serial.println(F("GPRS not connected !"));
            Serial.println(F("Reset the module."));
            sim800l -> reset();
            setupModule();
            return;
        }
    }

    Serial.println(F("Start HTTP POST..."));

    // Do HTTP POST communication with 10s for the timeout (read and write)
    uint16_t rc = sim800l -> doPost(URL, CONTENT_TYPE, message, 10000, 10000);
    if (rc == 200) {
        // Success, output the data received on the serial
        Serial.print(F("HTTP POST successful ("));
        Serial.print(sim800l -> getDataSizeReceived());
        Serial.println(F(" bytes)"));
        Serial.print(F("Received : "));
        Serial.println(sim800l -> getDataReceived());
    } 
    else {
        // Failed...
        Serial.print(F("HTTP POST error "));
        Serial.println(rc);
    }

    delay(300);

    // // Close GPRS connectivity (5 trials)
    // bool disconnected = sim800l -> disconnectGPRS();
    // for (uint8_t i = 0; i < 5 && !disconnected; i++) {
    //     disconnected = sim800l -> disconnectGPRS();
    //     if (!disconnected) delay(1000);
    // }

    // if (disconnected) Serial.println(F("GPRS disconnected !"));
    // else Serial.println(F("GPRS still connected !"));

    // // Go into low power mode
    // bool lowPowerMode = sim800l -> setPowerMode(MINIMUM);
    // if (lowPowerMode) Serial.println(F("Module in low power mode"));
    // else Serial.println(F("Failed to switch module to low power mode"));
}

void 
displayInfo()
{
    if (gps.location.isValid()) {
        Serial.print(gps.location.lat(), 6);
        Serial.print(",");
        Serial.print(gps.location.lng(), 6);
        Serial.print(" ");
    }

    Serial.print("Date/Time: ");
    if (gps.date.isValid()) {
        Serial.print(gps.date.month());
        Serial.print(F("/"));
        Serial.print(gps.date.day());
        Serial.print(F("/"));
        Serial.print(gps.date.year());
    }

    if (gps.time.isValid()) {
        Serial.print(" ");
        if (gps.time.hour() < 10) Serial.print(F("0"));
        Serial.print(gps.time.hour());
        Serial.print(F(":"));
        if (gps.time.minute() < 10) Serial.print(F("0"));
        Serial.print(gps.time.minute());
        Serial.print(F(":"));
        if (gps.time.second() < 10) Serial.print(F("0"));
        Serial.print(gps.time.second());
        Serial.print(F("."));
        if (gps.time.centisecond() < 10) Serial.print(F("0"));
        Serial.print(gps.time.centisecond());
    }

    Serial.println();
}

