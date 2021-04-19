(ns app.controllers.delete
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [app.views.navbar :refer [pages]]
            [app.models.depot :as model]))

(defn delete
  [request]
  (let [table (-> request :params :table keyword)
        id (-> request :params :id Integer/parseInt)]
    (cond
      (not (authenticated? request)) (redirect "/login")
      (nil? (table pages)) (redirect "/404")
      :else (try
              (do
                (model/delete table id)
                (redirect (str "/list/" (name table))))
              (catch java.sql.BatchUpdateException e (redirect "/"))))))
