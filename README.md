Materials for MicroService Workshop

* Booster 2014 in Bergen, Norway
* GOTO Chicago 2014


Docker was used to run RabbitMQ and the various services (Uganda class)

* Boot2Docker used
* dockerfile/rabbitmq image used
** docker pull dockerfile/rabbitmq
** docker run -d -p 5672:5672 -p 15672:15672 --name="rabbitmq" dockerfile/rabbitmq
** for restarting: docker start rabbitmq
** for console dumping: docker logs rabbitmq
