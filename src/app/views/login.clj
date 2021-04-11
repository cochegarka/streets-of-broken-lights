(ns app.views.login
  (:require [app.views.layout :refer [common]]
            [hiccup.page :as h]))

(defn login [request]
  (common "Вход в систему"
          [:section {:class "hero is-fullheight"}
           [:div {:class "hero-body"}
            [:div {:class "container has-text-centered"}
             [:div {:class "card"}
              [:header {:class "card-header"}
               [:p {:class "card-header-title"} "Вход в систему"]]
              [:div {:class "card-content"}
               [:div {:class "content"}
                [:form {:method "post"}
                 [:div {:class "field"}
                  [:label {:class "label"} "Имя пользователя"]
                  [:input {:type "text" :name "username"}]]
                 [:div {:class "field"}
                  [:label {:class "label"} "Пароль"]
                  [:input {:type "password" :name "password"}]]
                 [:div {:class "field"}
                  [:input {:class "button is-link" :type "submit" :value "Войти"}]]]]]]]]]))

