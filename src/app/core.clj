(ns app.core
  (:require [compojure.core :refer [defroutes GET POST]]
            [compojure.route :as route]

            [ring.middleware.session :refer [wrap-session]]
            [ring.middleware.params :refer [wrap-params]]
            [ring.adapter.jetty :as jetty]

            [buddy.auth.middleware :refer [wrap-authentication wrap-authorization]]

            [app.auth :refer [auth-backend]]
            
            [app.views.layout :refer [four-oh-four]]
            [app.views.home :refer [home]]
            [app.views.login :refer [login]]
            
            [app.controllers.login :refer [login-auth]]))

(defroutes routes
  (GET "/" [] home)
  (GET "/login/" [] login)
  (POST "/login/" [] login-auth)
  (route/not-found (four-oh-four)))

(defn -main []
  (def server
    (as-> routes $
      (wrap-authorization $ auth-backend)
      (wrap-authentication $ auth-backend)
      (wrap-params $)
      (wrap-session $)
      (jetty/run-jetty $ {:port 8080 :join? false}))))
