#include <TinyGPSPlus.h>
#include <SoftwareSerial.h>
#include "LoRaWAN.h"

#define POSITION_UPDATE_INTERVAL                      5000


SoftwareSerial* hSerialCommands = NULL;

char APPSKEY[] = "45:68:86:77:06:E0:3D:78:1F:6F:C4:F5:79:2C:94:C7";
char NWKSKEY[] = "47:9C:F4:F3:D0:88:D8:5D:BE:FD:74:19:D6:9A:EC:C0";
char DADDR[] = "26:0D:F8:DD";
char CHMASK[] = "ff00:0000:0000:0000:0002:0000";

static const int rxPin = 8, txPin = 3;
static const uint32_t gpsBaud = 9600;
TinyGPSPlus gps;
SoftwareSerial ss(rxPin, txPin);
unsigned long positionLastSentAt = 0;

void 
setup()
{
    Serial.begin(9600);

    // hSerialCommands = SerialCommandsInit(7, 6, 9600);
    // SendAtCommand(AT_NJM, AtSet, "0"); // altera a autenticação para ABP
    // SendAtCommand(AT_APPSKEY, AtSet, APPSKEY); 
    // SendAtCommand(AT_NWKSKEY, AtSet, NWKSKEY);
    // SendAtCommand(AT_DEVADDR, AtSet, DADDR); 
    // SendAtCommand(AT_CHMASK, AtSet, CHMASK);
    
    ss.begin(gpsBaud);
}

void 
loop()
{
    while (ss.available() > 0) {
        if (gps.encode(ss.read())) {
            // displayInfo();
            if (gps.location.isValid() && gps.time.isValid() && gps.date.isValid() &&
                millis() - positionLastSentAt > POSITION_UPDATE_INTERVAL) {
                sendPositionUpdate();
                positionLastSentAt = millis();
            }
        }
    }

    if (millis() > 5000 && gps.charsProcessed() < 10) {
        Serial.println("No GPS detected: check wiring.");
        while(true);
    }
}

void
sendPositionUpdate()
{
    char timestamp[25];
    snprintf(timestamp, 25, "%d-%02d-%02dT%02d:%02d:%02d.%03dZ", gps.date.year(),
             gps.date.month(), gps.date.day(), gps.time.hour(), gps.time.minute(),
             gps.time.second(), gps.time.centisecond());

    // 2017-06-14T17:52:25.428Z
    // 2022-03-17T19:13:27.000Z
//     char latitude[10];
//     char longitude[10];
//     dtostrf(gps.location.lat(), 6, 6, latitude);
//     dtostrf(gps.location.lng(), 6, 6, longitude);
//     char message[128];
//     snprintf(message, 128, "{\"data\":{\"position_monitoring\":[{\"location\":{\
// \"lat\": %.5f,\"lon\": %.5f},\
// \"timestamp\":\"%s\"}]}}", latitude, longitude, timestamp);
    char message[128];
    String body = "{\
        \"data\": {\
            \"position_monitoring\": [\
            {\
                \"location\": {\
                    \"lat\": " + String(gps.location.lat(), 6) + ",\
                    \"lon\": " + String(gps.location.lng(), 6) + "\
              },\
                \"timestamp\": \"" + String(timestamp) + "\"\
            }\
            ]\
        }\
    }";
    body.replace(" ", "");
    body.toCharArray(message, 128);
    Serial.println(message);
    // SendString("oioi", 2);
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

// 