(ns app.views.navbar
  (:require [hiccup.page :as h]))

(def pages
  {:vehicle "ТС"
   :car_owner "Владелец ТС" 
   :vehicle_passport "Паспорт ТС" 
   :insurance_policy "Страховой полис"
   :accident_card "Карточка учета ДТП" 
   :registration_certificate "Свидетельство о регистрации" 
   :registration_application "Заявка на регистрацию"
   :theft_statement "Заявление об угоне ТС"})

(def dropdown-add
  (mapv
   (fn [[k v]]
     [:a {:class "navbar-item" :href (format "/add/%s" (name k))} v])
   pages))

(def dropdown-list
  (mapv
   (fn [[k v]]
     [:a {:class "navbar-item" :href (format "/list/%s" (name k))} v])
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
     (let [{name :full_name
            position :name} (-> request :session :identity)]
       [:div {:class "navbar-item has-dropdown is-hoverable"}
        [:a {:class "navbar-link"} name]
        [:div {:class "navbar-dropdown"}
         [:a {:class "navbar-item has-text-weight-bold"} "Должность"]
         [:a {:class "navbar-item"} position]
         [:a {:class "navbar-item" :href "/logout"} "Выход"]]])]]])
