# Testes de performance do servidor MQTT do RabbitMQ

* Ambiente: macbook <-> gcloud n8-standard
* Dificuldade: 
	* RabbitMQ da plataforma está numa versão muito antiga (3.6.5) e toda
      a documentação disponível na internet não serve para a versão antiga
    * Arquivo de configuração do SSL para o plugin MQTT
    * Não é possível usar guest no MQTT
    * Foi necessário criar um usuário e setar as permissões
