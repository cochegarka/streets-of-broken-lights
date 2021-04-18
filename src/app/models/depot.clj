(ns app.models.depot
  (:require [clojure.java.jdbc :as j]))

(def spec
  {:dbtype "postgresql"
   :dbname "road_depot"
   :host "127.0.0.1"
   :user "ktxzkfkposkdiy"
   :password "postgres"})

(defn stats []
  (->
   (j/query spec ["SELECT * FROM get_stats()"])
   first))

(defn login [login password]
  (->
   (j/query spec ["SELECT * FROM log_in(?, ?)" login password])
   first :log_in))

(defn login-info [login]
  (->
   (j/query spec [(str "SELECT e.id, e.full_name, p.code, p.name
                       FROM credentials c, employee e, position p
                       WHERE c.login = ?
                       AND e.id = c.id_employee
                       AND p.id = e.id_position") login])))

(defn read-whole-table [table-name]
  (j/query spec [(format "SELECT * FROM %s" (name table-name))] {:as-arrays? true}))
