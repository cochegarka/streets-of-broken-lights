(ns app.views.home
  (:require [ring.util.response :refer [redirect]]
            [buddy.auth :refer [authenticated?]]
            [hiccup.page :as h]
            [app.views.layout :refer [common]]
            [app.views.navbar :refer [navbar]]))

(defn home
  [request]
  (if-not (authenticated? request)
    (redirect "/login/")
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
                  [:b "Транспортных средств: "] "NaN"]
                 [:div {:class "block"}
                  [:b "Владельцев ТС: "] "NaN"]
                 [:div {:class "block"}
                  [:b "Паспортов ТС: "] "NaN"]
                 [:div {:class "block"}
                  [:b "Страховых полисов: "] "NaN"]
                 [:div {:class "block"}
                  [:b "Свидетельств о регистрации ТС: "] "NaN"]
                 [:div {:class "block"}
                  [:b "Заявок на регистрацию: "] "NaN"]
                 [:div {:class "block"}
                  [:b "Заявлений об угоне: "] "NaN"]
                 [:div {:class "block"}
                  [:b "Карточек ДТП: "] "NaN"]]]]]])))
