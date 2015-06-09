(ns microservices-workshop.need
  (:gen-class)
  (:require [clojure.data.json :as json]
            [microservices-workshop.core :as core]))

(defn -main [& args]
  (let [host (first args)
        bus (second args)
        {:keys [conn ch]} (core/create-connection host bus)]
    (println " [*] Waiting for solutions on the bus... To exit press CTRL+C")
    (core/publish ch (json/write-str {:json_class "need.class" :need "car_rental_offer" :solutions []}))
    (core/close ch conn)))
