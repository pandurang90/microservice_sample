(ns microservices-workshop.core
  (:gen-class)
  (:require [langohr.core      :as rmq]
            [langohr.channel   :as lch]
            [langohr.queue     :as lq]
            [langohr.consumers :as lc]
            [langohr.basic     :as lb]
            [langohr.exchange  :as le]))

(def ^{:const true}
  default-exchange-name "rapids")

(def ^{:const true}
  qname "")

(defn create-connection [host bus]
  (let [conn (rmq/connect {:uri (format "amqp://%s:%s@%s/%s" bus bus host bus)})
        ch   (lch/open conn)
        q    (.getQueue (lq/declare ch qname {:exclusive false :auto-delete false}))]
      (le/declare ch default-exchange-name "fanout" {:durable true})
      (lq/bind ch q default-exchange-name)
      {:conn conn :ch ch}))


(defn publish [ch message]
  (lb/publish ch default-exchange-name qname message {:content-type "text/plain" :type "greetings.hi"}))

(defn subscribe [ch message-handler]
  (lc/blocking-subscribe ch qname message-handler {:auto-ack true}))

(defn close [ch conn]
  (rmq/close ch)
  (rmq/close conn))
