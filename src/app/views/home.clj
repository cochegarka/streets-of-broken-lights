(ns app.views.home
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [hiccup.page :as h]
            [app.views.layout :refer [common]]))

(defn home
  [request]
  (if-not (authenticated? request)
    (redirect "/login/")
    (common "Главная страница" [:div "Главная страница"])))
