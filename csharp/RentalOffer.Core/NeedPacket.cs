using System;
using System.Text;
using System.Collections.Generic;

using fastJSON;

namespace RentalOffer.Core {

    public class NeedPacket {

        public const string NEED = "car_rental_offer";

        private List<object> solutions = new List<object>();

        public IList<object> Solutions {
            get { return solutions.AsReadOnly(); }
        }

        public NeedPacket() {}

        public string ToJson() {
            // Clumsy, but this seems easier than dealing with
            // the JSON provider's idiosyncrasies to get snake-cased keys.
            IDictionary<string, object> message = new Dictionary<string, object>();
            message.Add("json_class", this.GetType().FullName);
            message.Add("need", NEED);
            message.Add("solutions", solutions);

            return JSON.ToJSON(message);
        }

        public void ProposeSolution(Object solution) {
            solutions.Add(solution);
        }

    }

}

