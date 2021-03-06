(ns app.views.list
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [hiccup.page :as h]
            [app.views.layout :refer [common]]
            [app.views.navbar :refer [navbar pages]]
            [app.models.depot :as model]
            [app.localization :as localization]))

(defn show-list
  [request]
  (let [table (-> request :params :table keyword)]
    (cond
      (not (authenticated? request)) (redirect "/login")
      (nil? (table pages)) (redirect "/404")
      :else (common (table pages)
                    [:section {:class "hero is-fullheight-with-navbar"}
                     [:div {:class "hero-head"}
                      (navbar (table pages) request)]
                     [:div {:class "hero-body"}
                      [:div {:class "container"}
                       (let [[head & data] (model/read-table-with-fk-substitution table)]
                         [:table {:class "table is-hoverable is-fullwidth"}
                          [:thead
                           (into [] (concat [:tr] (mapv (fn [x] [:th (localization/line x)]) head)))]
                          (into []
                                (concat
                                 [:tbody]
                                 (mapv
                                  (fn [x]
                                    (into []
                                          (concat
                                           [:tr]
                                           (mapv (fn [xx]
                                                   [:td [:a {:href (str "/edit/" (name table) "/" (first x))} xx]]) x)
                                           [[:td [:a {:href (str "/delete/" (name table) "/" (first x))} [:span {:class "icon"} [:i {:class "fas fa-trash"}]]]]]))) (sort-by first data))))])]]]))))
