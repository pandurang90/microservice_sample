(ns microservices-workshop.moniter
  (:gen-class)
  (:require [microservices-workshop.core :as core]))

(defn message-handler
  [ch {:keys [content-type delivery-tag] :as meta} ^bytes payload]
  (println (format " [x] Received %s" (String. payload "UTF-8"))))

(defn -main [& args]
  (let [host (first args)
        bus (second args)
        {:keys [conn ch]} (core/create-connection host bus)]
    (println (format " [*] Waiting for solutions on the %s bus... To exit press CTRL+C" bus))
    (core/subscribe ch message-handler)))
