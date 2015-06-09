using System;
using System.Text;
using RabbitMQ.Client;
using RabbitMQ.Client.MessagePatterns;

namespace RentalOffer.Core {

    public class Connection {

        private ConnectionFactory factory;
        private IModel channel;
        private string busName;
        private const string QUEUE = "";

        public Connection(string host, string busName) {
            this.busName = busName;
            factory = new ConnectionFactory {
                    HostName = host,
                    UserName = busName,
                    Password = busName,
                    VirtualHost = busName
               };
        }

        public void WithOpen(Action<Connection> action) {
            using (var connection = factory.CreateConnection()) {
                using (channel = connection.CreateModel()) {
                    channel.QueueDeclare(QUEUE, true, true, false, null);
                    channel.ExchangeDeclare("rapids", "fanout", true);
                    channel.QueueBind("", "rapids", "");

                    action(this);
                }
            }
        }

        public void Publish(string message) {
            var body = Encoding.UTF8.GetBytes(message);
            channel.BasicPublish("rapids", busName, null, body);
        }

        public Subscription Subscribe() {
            return new Subscription(channel, QUEUE);
        }
    }
}
