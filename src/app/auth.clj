(ns app.auth
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [buddy.auth.backends.session :refer [session-backend]]))

(defn unauthorized-handler
  [request metadata]
  (cond
    (authenticated? request)
    (-> "Not authenticated"
        (assoc :status 403))
    :else
    (let [current-url (:uri request)]
      (redirect (format "/login?next=%s" current-url)))))

(def auth-backend
  (session-backend {:unauthorized-handler unauthorized-handler}))
