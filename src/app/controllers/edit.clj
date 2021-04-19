(ns app.controllers.edit
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [app.views.navbar :refer [pages]]
            [app.models.depot :as model]))

(defn edit-post
  [request]
  (let [table (-> request :params :table keyword)
        id (-> request :params :id Integer/parseInt)]
    (cond
      (not (authenticated? request)) (redirect "/login")
      (nil? (table pages)) (redirect "/404")
      :else (try
              (do
                (model/update-from-form table id (:form-params request))
                (redirect (str "/list/" (name table))))
              (catch Exception e (redirect "/"))))))
