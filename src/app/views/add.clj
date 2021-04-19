(ns app.views.add
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [hiccup.page :as h]
            [app.views.layout :refer [common]]
            [app.views.navbar :refer [navbar pages]]
            [app.models.depot :as model]
            [app.localization :as localization]
            [clojure.string :refer [starts-with?]]))

(defn specialize-control [x type]
  (cond
    (starts-with? x "id_") (into []
                                 (concat [:select {:name x}]
                                         (mapv (fn [[id name]] [:option {:value id} name])
                                               (model/read-ids-and-alias (subs x 3)))))
    :else [:input {:class "input" :name x :type "text"}]))

(defn add
  [request]
  (let [table (-> request :params :table keyword)
        table-pages (table pages)]
    (cond
      (not (authenticated? request)) (redirect "/login")
      (nil? (table pages)) (redirect "/404")
      :else (common table-pages
                    [:section {:class "hero is-fullheight-with-navbar"}
                     [:div {:class "hero-head"}
                      (navbar (str "Добавление  -  " table-pages) request)]
                     [:div {:class "hero-body"}
                      [:div {:class "container is-max-desktop"}
                       [:div {:class "card"}
                        [:header {:class "card-header"}
                         [:p {:class "card-header-title"} table-pages]]
                        [:div {:class "card-content"}
                         (into [] (concat
                                   [:form {:action (str "/add/" (name table)) :method "post"}]
                                   (mapv
                                    (fn [[x type]] [:div {:class "field"}
                                                    [:label {:class "label"} (localization/line x)]
                                                    [:div {:class "control"}
                                                     (specialize-control x type)]])
                                    (->> (model/describe-table table)
                                         rest
                                         (filterv (fn [[x _]] (not= x "id")))
                                         (mapv (fn [[x _]] [x x]))))
                                   [[:div {:class "field"}
                                     [:div {:class "control"}
                                      [:button {:class "button is-link" :type "submit"} "Создать"]]]]))]]]]]))))

(defn add-post
  [request]
  (let [table (-> request :params :table keyword)]
    (cond
      (not (authenticated? request)) (redirect "/login")
      (nil? (table pages)) (redirect "/404")
      :else (do
              (common (table pages)
                      [:div (map (fn [[k v]] (println k)) (:form-params request))])
              ;(redirect (str "/list/" (name table)))
              ))))
