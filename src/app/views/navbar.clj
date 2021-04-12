(ns app.views.navbar
  (:require [hiccup.page :as h]))

(def pages
  [["ТС" "vehicle"]
   ["Владелец ТС" "owner"]
   ["Паспорт ТС" "passport"]
   ["Страховой полис" "policy"]
   ["Карточка учета ДТП" "accident_card"]
   ["Свидетельство о регистрации" "reg_cert"]
   ["Заявка на регистрацию" "reg_assignment"]
   ["Заявление об угоне ТС" "theft_stmt"]])

(def dropdown-add
  (mapv
   (fn [[caption name]]
     [:a {:class "navbar-item"} caption])
   pages))

(def dropdown-list
  (mapv
   (fn [[caption name]]
     [:a {:class "navbar-item"} caption])
   pages))

(defn navbar [title request]
  [:nav {:class "navbar is-dark has-background-dark" :role "navigation" :aria-label "main navigation"}
   [:div {:class "navbar-brand"}
    [:div {:class "navbar-item has-text-weight-bold"} title]]
   [:div {:id "app-navbar" :class "navbar-menu"}
    [:div {:class "navbar-start"}
     [:div {:class "navbar-item has-dropdown is-hoverable"}
      [:a {:class "navbar-link"} "Добавление"]
      (into [] (concat [:div {:class "navbar-dropdown"}] dropdown-add))]
     [:div {:class "navbar-item has-dropdown is-hoverable"}
      [:a {:class "navbar-link"} "Списки"]
      (into [] (concat [:div {:class "navbar-dropdown"}] dropdown-list))]]
    [:div {:class "navbar-end"}
     [:div {:class "navbar-item has-dropdown is-hoverable"}
      [:a {:class "navbar-link"} (format "%s" (get request :session))]
      [:div {:class "navbar-dropdown"}
       [:a {:class "navbar-item"} "Выход"]]]]]])
