(ns app.views.layout
  (:require [hiccup.page :as h]))

(defn common [title & body]
  (h/html5
   [:head
    [:meta {:charset "utf-8"}]
    [:meta {:http-equiv "X-UA-Compatible" :content "IE=edge,chrome=1"}]
    [:meta {:name "viewport" :content
            "width=device-width, initial-scale=1, maximum-scale=1"}]
    [:title title]
    (h/include-css "https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css")
    (h/include-css "https://use.fontawesome.com/releases/v5.0.13/css/all.css")]
   [:body body]))

(defn four-oh-four []
  (common "Страница не найдена"
          [:section {:class "hero is-fullheight"}
           [:div {:class "hero-body"}
            [:div {:class "container has-text-centered"}
             [:p {:class "title"} "Код 404"]
             [:p {:class "subtitle"} "Страница не найдена"]]]]))

