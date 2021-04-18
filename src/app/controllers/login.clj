(ns app.controllers.login
  (:require [ring.util.response :refer [redirect]]
            [app.models.depot :as model]))

(defn login-auth
  [request]
  (let [username (get-in request [:form-params "username"])
        password (get-in request [:form-params "password"])
        session (:session request)]
    (if (model/login username password)
      (let [next-url (get-in request [:query-params :next] "/")
            session-data (-> (model/login-info username) first)
            updated-session (assoc session :identity session-data)]
        (-> (redirect next-url)
            (assoc :session updated-session)))
      (redirect "/login"))))

(defn logout
  [request]
  (-> (redirect "/login")
      (assoc :session {})))

