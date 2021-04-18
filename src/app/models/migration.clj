(ns app.models.migration
  (:require [clojure.java.jdbc :as j]
            [app.models.depot :as model]))

(defn migrated? []
  (->
   (j/query model/spec
            ["SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public'"])
   first :count (partial <= 12)))

(defn migrate []
  (when (not (migrated?))
    (print "Creating database structure...") (flush)
    ; TODO
    (println "done")))

