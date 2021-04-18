(ns app.localization)

(def lines
  { :id "№"
   :register_sign "Регистрационный знак"
   :car_model "Модель"
   :color "Цвет"
   :id_car_owner "Владелец"
   :full_name "Полное имя"
   :date_of_birth "Дата рождения"
   :passport_number "Номер паспорта"
   :identification_number "Идентификационный номер"
   :car_category "Категория"
   :car_type "Тип"
   :chassis_number "Номер шасси"
   :body_number "Номер кузова"
   :engine_power "Мощность двигателя"
   :own_weight "Масса без нагрузки"
   :allowed_mass "Разрешенная масса"
   :issue_year "Год выпуска"
   :ecology_class "Экологический класс"
   :id_vehicle "ТС"
   :insurance_start "Дата начала страхования"
   :insurance_end "Дата окончания страхования"
   :issue_date "Дата оформления"
   :reason "Причина"
   :accident_type "Тип"
   :details "Детали происшествия"
   :id_employee "Сотрудник ГИБДД"
   :registration_number "Регистрационный номер"
   :registration_date "Дата регистрации"
   :id_registration_application "Заявление о регистрации"
   :receipt_number "Номер квитанции об оплате пошлины"
   :brief_info "Характеристика ТС"
   :appliance_date "Дата подачи"
   :status "Статус"
   :detailed_info "Детали происшествия"
   })

(defn line [k]
  (let [kwd (keyword k)]
    (or (kwd lines) (name k))))

