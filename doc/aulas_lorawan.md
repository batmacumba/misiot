### Modulo 1:

* IoT: sensors connected to internet and applications to analyze data
  * monitor and control devices
  * Kevin Ashton: 1999
* 1. Device to Device Communication
  2. Device to Cloud Communication
  3. Device to Gateway Communication
* **LPWAN**:
  1. Low Power
  2. Long Range 2-5km (urban), 10km (rural)
  3. sigfox, NB-IoT, LoRa
* **LORA**:
  1. Semtech
  2. Unlicensed, subgigahertz
  3. Chirp Spread Spectrum modulation
  4. Robust to interference

* LORA: modulation technology (data -> RF signal) - physical layer
* **LORAWAN**: software protocol
  1. Structure of data packets
  2. How packets are processed
  3. Encryption

-----

### Modulo 2:

* Range vs Energy vs Bandwidth

* **Lora**:
  * Low Cost, battery-powered, small packets, long distance
  * data -> bits -> modulation
  * **data rate**: 300bps - 11kbps
  * **maximum packet size**: 222 bytes high rate, 51 bytes low rate
  * **types of data**: sensor values, actuation commands

* **LoRaWAN**:

  * end devices: send data any time, can receive from network
  * localization possible with triangulation
  * 2-3 km urban, >5 km suburban, >50 km with visual line of sight
  * Long battery life (>1 years)
  * Low data rate (0.3 – 50 kbps)
  * Japan: listen before talk
  * **Elementos da rede**:
    1. Devices: send and receive data
    2. Gateways: transparent stateless access points, provide access to network server
    3. Network server: routing, gateway communication, encrypt/decrypt
    4. Application server: connects to network server
    5. Join server: handles activation and derives session keys

  * **Segurança**: network layer, application layer
  * 

https://www.hackster.io/Arn/single-channel-ttn-lora-gateway-and-nodes-with-esp32-sx1276-709612
https://robotzero.one/heltec-lora32-lorawan-node/