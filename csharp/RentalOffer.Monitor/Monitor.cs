using System;
using System.Text;

using RabbitMQ.Client;

using RentalOffer.Core;

namespace RentalOffer.Monitor {

    public class Monitor {

        private readonly string busName;

        public static void Main(string[] args) {
            string host = args[0];
            string busName = args[1];

            new Connection(host, busName).WithOpen(new Monitor(busName).MonitorSolutions);
        }

        public Monitor(string busName) {
            this.busName = busName;
        }

        private void MonitorSolutions(Connection connection) {
            var sub = connection.Subscribe();
            Console.WriteLine(" [*] Waiting for solutions on the {0} bus... To exit press CTRL+C", busName);

            while (true) {
                var e = sub.Next();
                var message = Encoding.UTF8.GetString(e.Body);
                Console.WriteLine(" [x] Received: {0}", message);
            }
        }

    }

}
