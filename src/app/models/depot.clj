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
  (j/query spec [(format "SELECT column_name, data_type FROM information_schema.columns WHERE table_name='%s'" (name table))] {:as-arrays? true}))

(defn read-ids-and-alias [ft]
  (mapv (fn [x] (into [] (take 2 x)))
        (rest
         (j/query spec [(format "SELECT * FROM %s" ft)] {:as-arrays? true}))))

(defn parse-form-value [v]
  (try
    (Integer/parseInt v)
    (catch Exception e
      (try
        (-> v java.time.LocalDate/parse java.sql.Date/valueOf)
        (catch Exception e v)))))

(defn insert-from-form [table form]
  (let [form (reduce-kv #(assoc %1 (keyword %2) (parse-form-value %3)) {} form)]
    (j/insert! spec table form)))

(defn update-from-form [table id form]
  (let [form (reduce-kv #(assoc %1 (keyword %2) (parse-form-value %3)) {} form)]
    (j/update! spec table form ["id = ?" id])))

(defn delete [table id]
  (j/delete! spec table ["id = ?" id]))

(defn get-row-by-id [table id]
  (first (j/query spec [(format "SELECT * FROM %s WHERE id = %d" table id)])))
