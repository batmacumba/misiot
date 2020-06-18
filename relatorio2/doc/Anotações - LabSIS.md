## Introdução

* explicar o que será coberto apresentação
* mencionar InterSCity
  * Interação com a API via requests HTTP
* motivação de usar MQTT no InterSCity pro projeto
  * Arduino Uno
  * LoRaWan - 243 bytes payload - não cabe JSON
  * 274 bytes request INCT em ASCII
* explicar brevemente MQTT
  * camada de aplicação normalmente sobre TCP/IP
  * entidades com suas funções
  * pub-sub: alguns clientes publicam e outros assinam tópicos (usenet, etc...)
  * mostrar figura e explicar **(difícil de ler)**
    * publishers podem ser assinantes

## Questões

* Explicar porque as questões antes
* Identificação do resource no InterSCity
  * UUID é enviado na URL do request
  * Correlação do dispositivo com o seu resource correspondente no INCT
* Conversão da estrutura de tópicos para a estrutura da API
  * voltar ao slide 3 e explicar
* Ponte entre servidor MQTT e a plataforma
  * *broker* só repassa aos assinantes, como repassar à plataforma
  * capabilities de atuador: plataforma publica num tópico
    * dar exemplo - semáforo, **que mais?**
* arquitetura INCT 
  * onde faz sentido fazer essa alteração
  * faz sentido criar um novo microserviço?

## Métodos 

## Cenários

## API

## O que já foi feito









