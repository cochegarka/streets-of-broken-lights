(ns app.views.edit
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [hiccup.page :as h]
            [app.views.layout :refer [common]]
            [app.views.navbar :refer [navbar pages]]
            [app.models.depot :as model]
            [app.localization :as localization]
            [clojure.string :refer [starts-with?]]))

(defn specialize-control [x type data]
  (cond
    (starts-with? x "id_") (into []
                                 (concat [:select {:name x}]
                                         (mapv (fn [[id name]] [:option {:value id} name])
                                               (model/read-ids-and-alias (subs x 3)))))
    (= type "text") [:textarea {:class "textarea" :name x :value ((keyword x) data)}]
    (= type "date") [:input {:class "input" :name x :type "date" :value ((keyword x) data)}]
    :else [:input {:class "input" :name x :type "text" :value ((keyword x) data)}]))

(defn edit
  [request]
  (let [table (-> request :params :table keyword)
        id (-> request :params :id Integer/parseInt)
        previous-data (model/get-row-by-id (name table) id)
        table-pages (table pages)]
    (cond
      (not (authenticated? request)) (redirect "/login")
      (nil? (table pages)) (redirect "/404")
      :else (common table-pages
                    [:section {:class "hero is-fullheight-with-navbar"}
                     [:div {:class "hero-head"}
                      (navbar (str "Редактирование  -  " table-pages) request)]
                     [:div {:class "hero-body"}
                      [:div {:class "container is-max-desktop"}
                       [:div {:class "card"}
                        [:header {:class "card-header"}
                         [:p {:class "card-header-title"} table-pages]]
                        [:div {:class "card-content"}
                         (into [] (concat
                                   [:form {:action (str "/edit/" (name table) "/" id) :method "post"}]
                                   (mapv
                                    (fn [[x type]] [:div {:class "field"}
                                                    [:label {:class "label"} (localization/line x)]
                                                    [:div {:class "control"}
                                                     (specialize-control x type previous-data)]])
                                    (->> (model/describe-table table)
                                         rest
                                         (filterv (fn [[x _]] (not= x "id")))))
                                   [[:div {:class "field"}
                                     [:div {:class "control"}
                                      [:button {:class "button is-link" :type "submit"} "Обновить"]]]]))]]]]]))))
