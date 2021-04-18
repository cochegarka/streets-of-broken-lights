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

(defn read-whole-table [table]
  (j/query spec [(format "SELECT * FROM %s" (name table))] {:as-arrays? true}))

(def foreign-keys
  {:vehicle {:car_owner :full_name}
   :accident_card {:employee :full_name}
   :vehicle_passport {:vehicle :car_model}
   :insurance_policy {:car_owner :full_name :vehicle :car_model}
   :registration_certificate {:employee :full_name :car_owner :full_name :registration_application :id}
   :registration_application {:car_owner :full_name :vehicle :car_model :employee :full_name}
   :theft_statement {:car_owner :full_name :vehicle :car_model :employee :full_name}})

(defn read-table-with-fk-substitution [table]
  (let [fk (table foreign-keys)
        table-name (name table)
        select-part (reduce-kv #(str %1 ", " (name %2) "." (name %3)) "" fk)
        from-part (reduce-kv (fn [a k _] (let [k (name k)] (str a ", " k))) "" fk)
        where-part (reduce-kv (fn [a k _] (let [k (name k)] (str a ", " k ".id = " table-name ".id_" k))) "" fk)
        where-part (if (empty? where-part) where-part (clojure.string/replace (str "WHERE " (subs where-part 1)) "," " AND"))
        query (format "SELECT %s.*%s FROM %s%s %s" table-name select-part table-name from-part where-part)
        [head & body] (j/query spec [query] {:as-arrays? true})
        fk-count (count fk)
        head (into [] (drop-last fk-count head))
        body (mapv (fn [x] (into [] (concat (take (- (count x) fk-count fk-count) x) (take-last fk-count x)))) body)]
    (-> (cons head body) (into []))))

(defn describe-table [table]
  (j/query app.models.depot/spec [(format "SELECT column_name, data_type FROM information_schema.columns WHERE table_name='%s'" (name table))] {:as-arrays? true}))

