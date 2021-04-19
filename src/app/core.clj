(ns app.core
  (:require [compojure.core :refer [defroutes GET POST]]
            [compojure.route :as route]

            [ring.middleware.session :refer [wrap-session]]
            [ring.middleware.params :refer [wrap-params]]
            [ring.middleware.reload :refer [wrap-reload]]
            [ring.adapter.jetty :as jetty]

            [buddy.auth.middleware :refer [wrap-authentication wrap-authorization]]

            [app.auth :refer [auth-backend]]
            
            [app.views.layout :refer [four-oh-four]]
            [app.views.home :refer [home]]
            [app.views.login :refer [login]]
            [app.views.list :refer [show-list]]
            [app.views.add :refer [add]]
            [app.views.edit :refer [edit]]
            
            [app.controllers.login :refer [login-auth logout]]
            [app.controllers.add :refer [add-post]]
            [app.controllers.delete :refer [delete]]
            [app.controllers.edit :refer [edit-post]]))

(defroutes routes
  (GET "/" [] home)
  (GET "/login" [] login)
  (POST "/login" [] login-auth)
  (GET "/logout" [] logout)
  (GET "/list/:table" [] show-list)
  (GET "/add/:table" [] add)
  (POST "/add/:table" [] add-post)
  (GET "/delete/:table/:id" [] delete)
  (GET "/edit/:table/:id" [] edit)
  (POST "/edit/:table/:id" [] edit-post)
  (route/not-found (four-oh-four)))

(defn -main []
  (def server
    (as-> routes $
      (wrap-authorization $ auth-backend)
      (wrap-authentication $ auth-backend)
      (wrap-params $)
      (wrap-session $)
      (wrap-reload $)
      (jetty/run-jetty $ {:port 3000 :join? false}))))

