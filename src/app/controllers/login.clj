(ns app.controllers.login
  (:require [ring.util.response :refer [redirect]]))

(def ^:private authdata
  {:admin "secret"
   :test "secret"})

(defn login-auth
  [request]
  (let [username (get-in request [:form-params "username"])
        password (get-in request [:form-params "password"])
        session (:session request)
        found-password (get authdata (keyword username))]
    (if (and found-password (= found-password password))
      (let [next-url (get-in request [:query-params :next] "/")
            updated-session (assoc session :identity (keyword username))]
        (-> (redirect next-url)
            (assoc :session updated-session)))
      (redirect "/login/"))))
