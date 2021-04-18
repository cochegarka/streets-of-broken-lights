(ns app.views.home
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [hiccup.page :as h]
            [app.views.layout :refer [common]]
            [app.views.navbar :refer [navbar]]
            [app.models.depot :as model]))

(defn home
  [request]
  (if-not (authenticated? request)
    (redirect "/login")
    (let [{cars :cars
           owners :owners
           passports :passports
           policies :policies
           certificates :certificates
           reg_applies :reg_applies
           theft_applies :theft_applies
           accident_cards :accident_cards} (model/stats)]
      (common "Главная страница"
              [:section {:class "hero is-fullheight-with-navbar"}
               [:div {:class "hero-head"}
                (navbar "Главная страница" request)]
               [:div {:class "hero-body"}
                [:div {:class "container has-text-centered is-max-desktop"}
                 [:div {:class "card"}
                  [:header {:class "card-header"}
                   [:p {:class "card-header-title"} "Статистика"]]
                  [:div {:class "card-content"}
                   [:div {:class "block"}
                    [:b "Транспортных средств: "] cars]
                   [:div {:class "block"}
                    [:b "Владельцев ТС: "] owners]
                   [:div {:class "block"}
                    [:b "Паспортов ТС: "] passports]
                   [:div {:class "block"}
                    [:b "Страховых полисов: "] policies]
                   [:div {:class "block"}
                    [:b "Свидетельств о регистрации ТС: "] certificates]
                   [:div {:class "block"}
                    [:b "Заявок на регистрацию: "] reg_applies]
                   [:div {:class "block"}
                    [:b "Заявлений об угоне: "] theft_applies]
                   [:div {:class "block"}
                    [:b "Карточек ДТП: "] accident_cards]]]]]]))))
