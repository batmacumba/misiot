#include <TinyGPSPlus.h>
#include <SoftwareSerial.h>
#include "LoRaWAN.h"

#define POSITION_UPDATE_INTERVAL                      5000
#define TIMESTAMP_LEN                                 25


SoftwareSerial* hSerialCommands = NULL;

// DEV EUI 0012F80000000DB3
char devEUI[] = "AT+DEUI=70:B3:D5:7E:D0:05:25:55";
char devAddr[] = "AT+DADDR="
// char appEUI[] = "AT+APPEUI=70:B3:D5:7E:D0:05:25:49"; 
char appsKey[] = "AT+APPKEY=F5:10:05:32:5D:10:48:2A:E2:05:C9:CE:A7:D9:5C:31"; 
char nwsKey[] = "AT+APPKEY=F5:10:05:32:5D:10:48:2A:E2:05:C9:CE:A7:D9:5C:31"; 
char chMask[] = "AT+CHMASK=FF00:0000:0000:0000:0001:0000"; // Banda 2 AUS
char joinNet[] = "AT+JOIN";
char rstLWM[] = "ATZ\r\n";
char setMode[] = "AT+NJM=1\r\n"; // 0 = ABP e 1 = OTAA

static const int rxPin = 8, txPin = 3;
static const uint32_t gpsBaud = 9600;
TinyGPSPlus gps;
SoftwareSerial ss(rxPin, txPin);
unsigned long positionLastSentAt = 0;

typedef struct {
    double latitude;
    double longitude;
    char timestamp[TIMESTAMP_LEN];
} payload;

bool
joinTTN()
{
    Serial.print("Reset interface LoRaWAN: "); 
    Serial.println(rstLWM);
    SendRaw(rstLWM);
    delay(200);

    SendRaw(setMode);
    delay(200);

    SendRaw(appKey);
    delay(200);

    SendRaw(appEUI);
    delay(200);

    SendRaw(chMask);
    delay(200);

    Serial.print("Enviando Join: "); 
    Serial.println(joinNet);
    SendRaw(joinNet);
    delay(1000);

    if (JoinNetwork(10) == RAD_OK) 
        Serial.println("EndDevice has joined sucessfully.");
    else
        Serial.println("Error joining the network.");
}
void 
setup()
{
    Serial.begin(9600);

    hSerialCommands = SerialCommandsInit(7, 6, 9600);
    joinTTN();
    
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

    // if (millis() > 20000 && gps.charsProcessed() < 10) {
    //     Serial.println("No GPS detected: check wiring.");
    //     while(true);
    // }
}

void
sendPositionUpdate()
{
    payload pl;
    // 2017-06-14T17:52:25.428Z
    snprintf(pl.timestamp, TIMESTAMP_LEN, "%d-%02d-%02dT%02d:%02d:%02d.%03dZ", gps.date.year(),
             gps.date.month(), gps.date.day(), gps.time.hour(), gps.time.minute(),
             gps.time.second(), gps.time.centisecond());

    pl.latitude = gps.location.lat();
    pl.longitude = gps.location.lng();

    char message[sizeof(payload)];
    memcpy(message, &pl, sizeof(payload));
    SendString(message, 2);
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

// function decodeUplink(input) {
//   return {
//     data: {
//       latitude: parseFloat(input.bytes.slice(0, 4)),
//       longitude: parseFloat(input.bytes.slice(4, 8)),
//       timestamp: String.fromCharCode(input.bytes.slice(8, 33))
//     },
//     warnings: [],
//     errors: []
//   };
// }

/////////////////////////////////////////////////////////////////////////////////

// /* Includes */

// #include "LoRaWAN.h"
// #include <SoftwareSerial.h>
// #include <stdint.h>

// /* SoftwareSerial handles */

// SoftwareSerial* hSerialCommands = NULL;

// /* Variables */

// char payLoad[] = "AT+SENDB=83:0248656C6C6F20576F77";

// char appEUI[] = "AT+APPEUI=70:B3:D5:7E:D0:05:25:49"; // Mudar
// char appKey[] = "AT+APPKEY=F5:10:05:32:5D:10:48:2A:E2:05:C9:CE:A7:D9:5C:31"; // mudar
// char chMask[] = "AT+CHMASK=FF00:0000:0000:0000:0001:0000"; // Banda 2 AUS
// char joinNet[] = "AT+JOIN";
// char rstLWM[] = "ATZ\r\n";
// char setMode[] = "AT+NJM=1\r\n"; // 0 = ABP e 1 = OTAA

// char resposta [40];
// uint8_t tamanho;

// char *pontResp;
// uint8_t *pontTam;

// void setup()
// {
// pontResp = &resposta[0];
// pontTam = &tamanho;

// Serial.begin(9600);
// Serial.println("\n\nIniciando…");

// hSerialCommands = SerialCommandsInit(7, 6, 9600);

// Serial.print("Reset interface LoRaWAN: "); Serial.println(rstLWM);
// SendRaw(rstLWM);
// delay(1000);

// SendRaw(setMode);
// delay(1000);

// SendRaw(appKey);
// delay(1000);

// SendRaw(appEUI);
// delay(1000);

// SendRaw(chMask);
// delay(1000);

// Serial.print("Enviando Join: "); Serial.println(joinNet);
// SendRaw(joinNet);
// delay(1000);

// if(JoinNetwork(10) == RAD_OK)
// {
// Serial.println("EndDevice has joined sucessfully.");
// }
// else
// {
// Serial.println("Error joining the network.");
// }

// SendRaw("AT+NJS=?");
// delay(1000);
// if (ReceivePacketCommand(pontResp, pontTam, 2000) == RAD_OK)
// Serial.println("Radio OK");
// else
// Serial.println("Radio nOK");
// Serial.print("Resposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// }

// /* Loop ---------------------- */

// void loop()
// {
// SendRaw("AT+DEUI=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+DADDR=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.println(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+APPKEY=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+APPSKEY=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+NWKSKEY=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+APPEUI=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+VER=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+CFM=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+DR=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+RX1DL=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw("AT+RX2DL=?");
// delay(1000);
// for (int i=0; i < 40; i++) resposta[i] = 0x00;
// ReceivePacketCommand(pontResp, pontTam, 2000);
// Serial.print("\nResposta: "); Serial.print(resposta);
// Serial.print("Tamanho: "); Serial.println(tamanho);

// SendRaw(payLoad);
// Serial.print("\nWait\n");
// delay(30000);

// }