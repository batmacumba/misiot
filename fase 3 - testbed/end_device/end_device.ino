/******************************************************************************/
/********************************** ABP ***************************************/
/******************************************************************************/

#include "LoRaWAN.h"
#include <SoftwareSerial.h>
#include <stdint.h>

SoftwareSerial* hSerialCommands = NULL;

char APPSKEY[] = "45:68:86:77:06:E0:3D:78:1F:6F:C4:F5:79:2C:94:C7";
char NWKSKEY[] = "47:9C:F4:F3:D0:88:D8:5D:BE:FD:74:19:D6:9A:EC:C0";
char DADDR[] = "26:0D:F8:DD";
char CHMASK[] = "ff00:0000:0000:0000:0002:0000";

char str_counter[32];
int counter = 0;

void setup() 
{
    Serial.begin(9600); /* Initialize monitor serial */
    Serial.println("Initializing...");
    delay(1000);

    /* Initialize SoftwareSerial */
    hSerialCommands = SerialCommandsInit(7, 6, 9600);
    
    SendAtCommand(AT_NJM, AtSet, "0"); // comando para alterar a autenticação para ABP
    SendAtCommand(AT_APPSKEY, AtSet, APPSKEY); 
    SendAtCommand(AT_NWKSKEY, AtSet, NWKSKEY);
    SendAtCommand(AT_DEVADDR, AtSet, DADDR); 
    SendAtCommand(AT_CHMASK, AtSet, CHMASK);
}

void loop() 
{
    /* Sends a string containing a counter every 15s */
    sprintf(str_counter, "Counter: %d\r\n\0", counter++);
    Serial.println(str_counter);
    SendString(str_counter, 2);
    delay(15000);
  
}

/******************************************************************************/
/********************************* OTAA ***************************************/
/******************************************************************************/

// #include "LoRaWAN.h"
// #include <SoftwareSerial.h>
// #include <stdint.h>

// SoftwareSerial* hSerialCommands = NULL;

// char APPKEY[] = "10:9F:47:AB:58:28:32:71:80:9A:14:DF:35:CE:BB:75";
// char APPEUI[] = "d9:8c:fb:ab:a0:3a:7a:00";
// char CHMASK[] = "ff00:0000:0000:0000:0002:0000";
// char str_counter[32];
// int counter = 0;

// void setup() {
//   Serial.begin(9600); /* Initialize monitor serial */
//   Serial.println("Initializing...");
//   delay(10000);

//   /* Initialize SoftwareSerial */
//   hSerialCommands = SerialCommandsInit(7, 6, 9600);
  
//   /* Configure the EndDevice as OTAA */
//   InitializeOTAA(APPKEY, APPEUI);
//   SendAtCommand(AT_CHMASK, AtSet, CHMASK);
//   Serial.println("Sending JOIN.");
//   if(JoinNetwork(0) == RAD_OK)
//   {
//     Serial.println("EndDevice has joined sucessfully.");
//   }
//   else
//   {
//     Serial.println("Error joining the network.");
//   }
// }

// void loop() {
//   /* Sends a string containing a counter every 15s */
//   sprintf(str_counter, "Counter: %d\r\n\0", counter++);
//   Serial.println(str_counter);
//   SendString(str_counter, 2);
//   delay(15000);
// }

/******************************************************************************/
/********************************* DEVUI **************************************/
/******************************************************************************/


// /* Includes ---------------------- */
// #include <SoftwareSerial.h>
// #include <stdint.h>

// SoftwareSerial SWSerial(7, 6);  //D2, D1 : SerÃ¡ usada a serial por software para comunicar com o EndDevice para deixar livre a serial do monitor serial


// char lerSerial();
// char TrataRX(byte indice);


// char inData[255]; // Buffer com tamanho suficiente para receber qualquer mensagem
// char inChar=-1; // char para receber um caractere lido
// byte indice = 0; // Ã­ndice para percorrer o vetor de char = Buffer
// char flag= false; //flag usada para avisar que a serial recebeu dados

// char inDataSerialMonitor[255]; // Buffer com tamanho suficiente para receber qualquer mensagem
// char inCharSerialMonitor=-1; // char para receber um caractere lido
// byte indiceSerialMonitor = 0;
// char flagMonitorSerial = false;

// char str_counter[128];
// char flag_timer = false;
// int tempo =0;
// int counter = 0;
// int acumula_erros = 0;


// void setup() {
//   // put your setup code here, to run once:
//   pinMode(LED_BUILTIN, OUTPUT);
//   Serial.begin(9600); /* Initialize monitor serial */
//   Serial.println("Initializing...");
//   delay(500);
//   SWSerial.begin(9600);
//   delay(500);
//   //timer
//   // ConfiguraÃ§Ã£o do timer1 
//   TCCR1A = 0;                        //confira timer para operaÃ§Ã£o normal pinos OC1A e OC1B desconectados
//   TCCR1B = 0;                        //limpa registrador
//   TCCR1B |= (1<<CS10)|(1 << CS12);   // configura prescaler para 1024: CS12 = 1 e CS10 = 1
//   TCNT1 = 0xC2F7;                    // incia timer com valor para que estouro ocorra em 1 segundo
//                                      // 65536-(16MHz/1024/1Hz) = 49911 = 0xC2F7
//   TIMSK1 |= (1 << TOIE1);           // habilita a interrupÃ§Ã£o do TIMER1


//   //configuraÃ§Ã£o do EndDevice
// //STRING 01 = ativaÃ§Ã£o OTAA
// SWSerial.println("AT+DEUI=?");
// delay(15);
// //STRING 02 = liga mensagem automÃ¡tica de keepalive a cada 1 minuto
// SWSerial.println("AT+KEEPALIVE=1:215:1:60000");
// delay(15);
// //STRING 03 = join automatico
// SWSerial.println("AT+AJOIN=1");
// delay(15);
// //STRING 04 = nÃ£o salva o Contador de pacotes
// SWSerial.println("AT+SFCNT=0");
// delay(15);
// //STRING 05 = MÃ¡scara de canais
// SWSerial.println("AT+CHMASK=ff00:0000:0000:0000:0002:0000");
// delay(15);
// //STRING 06 = cÃ³digo da sua aplicaÃ§Ã£o (esta Ã© realmente a sua aplicaÃ§Ã£o)
// SWSerial.println("AT+APPEUI=70:B3:D5:7E:D0:03:35:DD");
// delay(15);
// //STRING 07 = chave de autenticaÃ§Ã£o appkey (verifique se estÃ¡ correta ... EndDevice rd50c)
// SWSerial.println("AT+APPKEY=B3:61:61:52:2D:72:04:34:91:86:FD:AB:3D:5A:8A:AD");
// delay(15);
// //STRING 08 = Configure o GPIO 0 (pino 6) para entrada analÃ³gica.
// SWSerial.println("AT+GPIOC=0:5:0");
// delay(15);
// //STRING 09 = reset
// SWSerial.println("ATZ");
// delay(15);


  
// }

// void loop() {
//   // put your main code here, to run repeatedly:

//     flag= LerSerial(); // verifica se a serial por software recebeu alguma informaÃ§Ã£o. Ser quiser usar a serial nativa para receber dados...  tem que implementar uma nova funÃ§Ã£o.
//     if (flag)//pode-se colocar o LerSerial() dentro do if, mas fica mais claro de mostrar usando a flag.
//     {
//       TrataRX(indice);//chama a funÃ§Ã£o que vai interpretar o que foi recebido na serial por software
//     }
//  // delay(5000);
//   if(tempo%10 == 0 && flag_timer == true)
//   {
//     counter++;
//     Serial.println(counter);
//     //sprintf(str_counter, "AT+TXCFM=57:1:1:FAB100:%d", counter++);
//     //SWSerial.print(str_counter);
//     flag_timer = false;
//   }

//   flagMonitorSerial = LerSerialMonitor();
//   if (flagMonitorSerial)
//   {
//     //Encaminha o que recebeu na serial do monitor para a serial do EndDevice
//      SWSerial.println(inDataSerialMonitor);
//   }
// }


// //================== tratamento do que recebeu na SW serial ========================
// char TrataRX(byte indice) 
// {
//       Serial.println(inData); //mostra no console serial
//       char * ack;  
//       char * nack;
//       ack = strstr (inData, "AT_ACK_OK");
//       nack = strstr (inData, "AT_ACK_ERROR");
//       if (ack)
//       {
//           counter=0;
//           Serial.println("ACK = OK");
//       }
//       else if (nack)
//       {
//         Serial.print("Erro ACK. Total de erros: ");
//         Serial.print( acumula_erros++);
//       }
        
     
// }

// char LerSerial( ) 
// {
//     indice=0;
//     while (SWSerial.available() > 0) // Don't read unless// there you know there is data
//     {
//         if(indice < 254) // One less than the size of the array
//         {
//             inChar = SWSerial.read(); // Read a character
//             inData[indice] = inChar; // Store it
//             delay (10);
//             indice++; // Increment where to write next
//             inData[indice] = '\0'; // Null terminate the string
//         }        
//     }
//     if(indice>0) 
//     {
//         return(1); //retorno da funÃ§Ã£o avisando que recebeu dados na serial
//     }
//     else
//     {
//       return (0);
//     }

// }

// char LerSerialMonitor( ) 
// {
//     indiceSerialMonitor=0;
//     while (Serial.available() > 0) // Don't read unless// there you know there is data
//     {
//         if(indiceSerialMonitor < 254) // One less than the size of the array
//         {
//             inCharSerialMonitor = Serial.read(); // Read a character
//             inDataSerialMonitor[indiceSerialMonitor] = inCharSerialMonitor; // Store it
//             delay (10);
//             indiceSerialMonitor++; // Increment where to write next
//             inDataSerialMonitor[indiceSerialMonitor] = '\0'; // Null terminate the string
//         }        
//     }
//     if(indiceSerialMonitor>0) 
//     {
//         return(1); //retorno da funÃ§Ã£o avisando que recebeu dados na serial
//     }
//     else
//     {
//       return (0);
//     }

    
// }


// ISR(TIMER1_OVF_vect)                              //interrupÃ§Ã£o do TIMER1 
// {
//   TCNT1 = 0xC2F7;                                 // Renicia TIMER
//   digitalWrite(LED_BUILTIN, digitalRead(LED_BUILTIN) ^ 1); //inverte estado do led
//   flag_timer = true;
//   tempo++;
// }