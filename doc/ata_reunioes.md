# Ata Reuniões - Projeto IC

[Pasta no drive do Daniel](https://drive.google.com/drive/folders/1bO376kL2InpR2nu9MW8l0BNKO_s5DZuj?usp=sharing)
[Repo do MQTT](https://github.com/mqtt/)
[Awesome MQTT](https://github.com/hobbyquaker/awesome-mqtt)


#### 20/03/2020:
* InterSCity:
	* middleware
	* API
	* FI-WARE

* MQTT:
	* Raspberry sensores (temp/luz)
	* Le os sensores e envia em um tópico
	* Modificar a plataforma pra receber MQTT
	
--------------------------------------------------------------------------------

#### 27/03/2020:
* Cronograma de quando cheqgarão gateways e raspis
* Kong API gateway
* Vale a pena a integração total no Ruby do InsterSCity?

* Instalação da plataforma instala MQTT
* MQTT autocontido
* Funcionalidades MQTT na plataforma:
	* acesso à esses dados na plataforma
	* cliente componente na plataforma, lê todos os tópicos e guarda
	* fuçar servidores
	* rodar cliente ruby
	* escreve string/lê string 1000 chars: medir o tempo de leitura/escrita do cliente ruby. mandar primeiro número 1, depois string 1000. repetir 10 vezes
	* como a plataforma guarda dados?

* Lâmpadas suportam MQTT, suportam REST? Suportar Sonoff? Pesquisa de mercado sobre os dispositivos IoT

--------------------------------------------------------------------------------

#### 02/04/2020:
* 1o teste localhost (feito)
* 2o teste SSL 
* 3o testar ambiente natural na próxima semana broker <-> cliente (mbp <-> mba)
* REUNIAO: explicar antes de usar simuladores
* 4o usar simulador de redes (tc cbq)
* analise de dados pra redes
* relatório parcial que justifique a escolha
* ferramenta benchmark mqtt ruby
* INTERNET NO CRUSP

--------------------------------------------------------------------------------

#### 16/04/2020:
* interação entre Brunos
* TTN
* o que vai rodar na interscity?
* arquitetura da rede?

* repetir testes de spread
* plotar ic e stdv 
* vira relatório da pesquisa
* overleaf: template report 
* conclusão do ambiente escolhido: mosquitto se comportou de maneira mais consistente, aedes fica bom, hivemq erratico problema mais a frente seja causado por ele
* mostrar na quinta e sexta daniel manda
* ver como junta no interscity
* integrar ao TTN
* d3.js para plotar?

--------------------------------------------------------------------------------

#### 23/04/2020:

[FRIDA FINANCIAMENTO](https://programafrida.net/pt-br/oportunidades-de-financiamento-do-frida)

1. introdução -> motivação para se preocupar com segurança e consumo de recursos do protocolo MQTT (pode usar - copiar mesmo - qualquer conteúdo sobre isso que já esteja na sua proposta e na proposta do projeto inteiro) (2 parágrafos)
1 - introdução -> terminar a seção falando: "Este relatório apresenta..."

2. ambiente de experimentação -> preferencialmente com figuras mostrar as redes onde vc fez as medições - informar hardware, software e capacidade das redes

3. Implementações de Servidores MQTT -> aquela tabela com as várias implementações de servidores (a mesma que está no drive do google) e explica que desses 5, os experimentos foram feitos com 3: hive, mosquitto e aedes. Explique que os outros 2 não foram possíveis instalar por causa de  ...

4. Experimentos planejados -> Explica quais são os dois conjuntos de experimentos (leitura e escrita) - cada conjunto tem dois subconjuntos (1 byte e 1000 bytes)

5. Resultados encontrados -> Mostrar um fluxograma de como tudo foi feito. Nesta seção vc tb tem que explicar como vc mediu e também disponibilizar os códigos (pode ser um .zip no drive) que vc usou (não precisa criar um repositório só pra isso super documentado). Finalmente apresentar os gráficos e tabelas mostrando tudo que foi medido

6. Conclusões -> Bem curta, com 1 parágrafo falando qual é o servidor MQTT indicado para ser usado daqui pra frente dentro / junto da plataforma InterSCity

* organizar o material
* pesquisar plataforma interscity
* pensar como ligar a plataforma ao mqtt

--------------------------------------------------------------------------------
#### 04/05/2020:

* colocar broker mqtt na mesma maquina
* manda msg pro broker, plataforma 
* consertar barra inferior
* nos casos em que a barra inferior nao esta sendo exibida, a meta inferior da barra foi omitida
* processo esperando mensagem da plataforma
* cliente conecta ao broker mqtt, mensagem chegar ao cara ligado na plataforma
* script que faça a conexao das duas coisas
* escrever uma aplicacao que faça isso: servir de experimento base
* app usa a plataforma rest api e consiga fazer um processo num computador converse
  com a plataforma mandando um char, e um string. app 
* montar ambiente com opções de conexão e integração
* qualitativa fazer tal coisa com rest api x fazer tal coisa com mqtt
* contar linhas de código a mais com rest api: se mqtt ja estivesse na plataforma
  seria mais fácil?
* acessar remotamente
* só api por enquanto para o teste acima

###### Cenário 1:
* onibus tem sensores que comunicam com a rest api da interscity
* empresa fabrica equipamento mqtt de onibus: so configura IP e enviar dados a servidor
* mqtt precisa enviar ao broker do interscity, e a api existente precisa ingerir para mostrar graficos normalmente

###### Mais tarde:
* simular cenario de onibus

* OBJETIVO: MONTAR AMBIENTE DE EXPERIMENTACAO
experimento acima 

--------------------------------------------------------------------------------
#### 12/05/2020 - Reunião MISIOT

* avaliar maneiras de integração: consumo de cpu, performance, consumo de rede
* sensor -> LORA -> gateway -> IP -> TTN -> MQTT 
* https://www.thethingsnetwork.org/docs/applications/mqtt/api.html
* INCT recebe AES modo CTR
* INCT microserviço para tratar dados criptografados

--------------------------------------------------------------------------------
#### 14/05/2020

###### Dificuldades para deploy do INCT:
* arquivo hosts: qual o arquivo certo para o deploy local?
* qual o arquivo de README certo? (HACKING.md confundiu)
* SO, memória e HD antes de qualquer instrução
* alguns microserviços não sobem as vezes

###### Teste API INCT:
* instância rodando na AWS
* teste pronto de escrita
* intervalo médio: 61ms
* dificuldade de fazer a plataforma contactar o webhook

###### Formas de integrar MQTT na plataforma
* implementar em ruby um broker:
	+ alta customização da integração
	+ comunicação direta via RabbitMQ com os outros módulos
	- altíssima complexidade para lidar com a arquitetura existente
	- tempo para executar a tarefa é longo

* rodar o servidor MQTT na máquina e transferir por meio de arquivos:
	- mosquitto somente guarda as mensagens em trânsito no mosquitto.db
	+ é possível hackear db_dump para fazer o broker dump as mensagens (https://github.com/eclipse/mosquitto/issues/337)
	+ simples parse dos arquivos para atualizar
	- como escalar?

* rodar o servidor MQTT em qualquer máquina e ter um cliente ingerindo todos os tópicos
	- não existe tópico privado?
	+ mais simples de implementar: módulo mqtt client opcional na hora de subir o servidor
	+ flexibilidade para executar o próprio MQTT ou só usar um servidor existente


###### Feedback Daniel:

* video inct: https://drive.google.com/drive/folders/1cBtYMgO6sjYywHQnFwzrNJf0g72k_v2B 
* formalizar mais as propostas
* frase dizendo como faz, figura, comparação tabela prós e contras
* colocar cada um um documento semelhante ao relatorio
* frase explicando o que faz cada uma
* fecha com uma tabela de pros e contras

* depois de fechar o relatorio, pensar em um cenario de justificativa para desenvolver a integração MQTT/API
* procurar no google cenários: comprar dispositivo mqtt (até 5x $40 - mqtt/lora/wifi)

--------------------------------------------------------------------------------
#### Workshop INCT

###### Cenário 1: Qualidade do Ar
* sensores de qualidade do ar nos ônibus
* fazem o upload para o INCT quando chegam na garagem
* usam a infraestrutura do INCT para a leitura dos dados

###### Cenário 2: Ruído
* sensores de áudio, humidade e temperatura em totens na cidade
* enviado ao INCT através de 3G ou WiFi
* usam a infraestrutura do INCT para a leitura dos dados
* mapa de ruídos: barulhometro.com.br

###### Cenário 3: Desastres Naturais
* pluviômetro, sensor de humidade
* enviado ao INCT através de LoRa
* precisam dos dados anteriores para saber quando os dados atuais serão preocupantes e sinalizam um desastre

###### Cenário 4: Monitoramento de Lixeiras (Poliana)
* sensor ultra-sônico -> Arduino -> lora

###### Cenário 5: Monitoramento Nível dos Rios
* sensor ultra-sônico: Medir altura da coluna de água
* enviar via LoRa

###### módulo LORA Sx1278 R$40

--------------------------------------------------------------------------------
#### 28/04/2020

* feedback
* opções que vamos utilizar em negrito
* olhar os testes da plataforma: se já existirem testes de rede do INCT, usá-los
* testes fazem ponte MQTT->API, API->MQTT, MQTT->MQTT, ?
* testes farão análise de desempenho
* pode mandar antes da próxima quinta
* fuçar testes: se não valer a pena, partir pra implementar

--------------------------------------------------------------------------------
#### 02/06/2020

* Testes só de integridade: https://gitlab.com/interscity/interscity-platform/interscity-platform/-/tree/master/src/test

###### Estudo INCT:
* Resources: câmeras, sensores, etc
* Capabilities: tipo de dados que os recursos enviam
* Resource Adaptor: recebe os dados dos dispositivos
* Resource Cataloguer: gerencia dados estáticos dos recursos (metadados)
* Data Collector: armazena dados dos sensores, prove acesso aos dados
* Resource Discoverer: ajuda a pesquisar recursos
* Actuator Controller: gerencia atuações
* Data processor: analisa dados, processamento em cluster
* Resource Viewer: apresenta visualizações dos dados

###### Uso INCT:
* Criar capacidades
* Criar recurso que use a capacidade

###### Conversa Higor: 
* 1o cenário cliente MQTT melhor cenário
* Rabbit MQ comunica entre os serviços
* 2o cenário possível também
* cuidado com race condition
* **apresentar proposta da lógica de adaptação do MQTT na reunião do grupo de sistemas - terça 14h - convocar ainda participação do pessoal da pragma code**

-------------

#### 04/06/2020
* apresentar proposta
* decidir sobre apresentação da proposta no lab de sistemas e/ou poliana
* decidir sobre B.Rotondaro cooperação no projeto

#### Feedback Daniel
* redundância de servidor MQTT?
* uuid como identificador: verificar se é possível no sonoff?
* verificar o que acontece quando não existem subscribers em um tópico
* flexibilidade vs funcionalidade
* cenários simples e depois vamos dificultando
* considerar que não existirão capabilities não cadastradas
* tentar criar cenário com condição de corrida no futuro
* entregar primeiro com Mosquitto e no futuro colocar o TTN

##### Apresentação grupo de sistemas - terça 23/06
* apresentar método de integração: Cliente MQTT, RabbitMQ
* apresentar também "API" MQTT
* cenários integração MQTT INCT
* SLIDES 18/06
* APRESENTAÇÃO 23/06

-----------
#### 16/06/2020 - Reunião MISIOT
* não nos preocupamos com como ligar ao inct
* implementamos sensor -> mqtt
* o que acontece com as capabilities de atuador? podemos forward todos os atuadores pro servidor MQTT - vai ser necessário mexer em outros arquivos

### Reunião

* como ter um dado protegido no inct
* reunião com o pessoal do pragma 
* webinar teve um pessoal usando mqtt no inct - grupo de um Fabio
* mostrar na apresentacao algo sobre UUID

---------

### 18/06/2020

* preciso explicar resources e capabilities? sim
* trabalho da UFG muito parecido - DB
* tempo da apresentação - max 15min, ideal 10min



#### Feedback

* protocolo aberto - falar dos brokers testados antes dos cenários
* falar da escolha do mosquito - fazer tabela sobre cada um: licença, data da versão, linguagem, ranking por performance, criptografia
* falar sobre resources e capabilities - slide 2
* mostrar URL com UUID
* figura dispositivos IoT
* mqtt mais leve que amqp e copa
* mandar slides antes da terça
* como pausar relógio?

---------

### 21/06/2020 - Checklist Apresentação LabSIS

- [x] SVG mais nítidoC
- [x] Relatório 1 - performance Mosquitto
- [x] Explicar resources e capabilities
- [x] Terminar implementação - direcionar script pro playground
- [x] Terminar slide - o que já foi feito

-------

### 25/06/2020

* **cuidado para não duplicar dados quando houver mais de uma instância do client MQTT funcionando na plataforma!!**

#### Reunião Diego e Higor:

* higor acha melhor só modificar o resource-adaptor para manter os testes funcionando - também acha possível que uma só instância do RA possa falar mqtt e rest
* diego concorda em não criar microserviço separado
* escrever gem e encapsular nos serviços - separar comunicação externa de comunicação interna
* kong gateway - não redireciona MQTT, só HTTP - kong fecha todas as portas?
  1. implementar MQTT no : https://github.com/Kong/kong/issues/1219
  2. rabbitmq não passa pelo kong

* portas da plataforma fechadas pra internet
* SSL na plataforma: kongapi gateway ssl
* autenticação: 
* somente modo ABP - chave fixa: ao criar o resource eu passo a chave AppSessionKey
* 1. Crio uma chave API
     * INCT só me dá acesso aos meus resources
     * Chave de grupo?
  2. Cada resource criado, pode aceitar uma chave AppSession
     * chave recurso, chave aplicação?
     * protegido ou não
  3. Cada atualização do servidor MQTT, adaptador checa se há chave LoRaWAN e descriptografa, guardando
  4. Ativar SSL/TLS

**SEPARAR PROPOSTA INTEGRAR MQTT, INTEGRAR LORAWAN - MUITO DIFERENTE**

* como mexer no resource-adaptor: adicionar o campo da chave ABP
* não é possível criar RabbitMQ separado - servidor MQTT está no TTN

https://trello.com/b/dwRIH5My/misiot
https://gitlab.com/batmacumba/interscity-platform
https://docs.google.com/document/d/1r8t_uGXFqMn68BNbc_VFRX4DIZDkEJyRWBkCu31AYr4/edit



--------

### 02/07/2020

* Poliana vai buscar os dados no TTN ou talvez no gateway, com os dados ainda criptografados. O que fazemos? Adaptamos ao TTN ou esperamos ela definir o formato?

https://www.thethingsnetwork.org/forum/t/gateway-data-retrieval-over-mqtt/21424/3

https://www.thethingsnetwork.org/community/berlin/post/ttn-api-request-for-gateways



#### Feedback:

* ir até o final de cada modelo (MQTT, TTN)
* sondar no grupo da cripto e do imesec - precisamos de um aluno de graduação para trabalhar com criptografia
* continuar no trajeto anterior - rabbitmqtt, cliente mqtt, ttn








