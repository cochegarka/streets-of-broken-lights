(ns app.controllers.add
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [app.views.navbar :refer [pages]]
            [app.models.depot :as model]))

(defn add-post
  [request]
  (let [table (-> request :params :table keyword)]
    (cond
      (not (authenticated? request)) (redirect "/login")
      (nil? (table pages)) (redirect "/404")
      :else (try
              (do
                (model/insert-from-form table (:form-params request))
                (redirect (str "/list/" (name table))))
              (catch Exception e (redirect "/"))))))
