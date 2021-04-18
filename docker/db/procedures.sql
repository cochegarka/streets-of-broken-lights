-- Добавить владельца ТС, если он еще не добавлен, проверить, соответствуют ли номер паспорта и остальные данные, вернуть id
create or replace function insert_car_owner(name varchar(255), birthdate date, passnum integer)
    returns integer
    language plpgsql
as
$$
declare
    result   integer;
    fullname varchar(255);
    dob      date;
begin
    if exists(select *
              from car_owner
              where passport_number = passnum)
    then
        select id, full_name, date_of_birth from car_owner where passport_number = passnum into result, fullname, dob;
        assert fullname = name and dob = birthdate, 'Same passport number, different name and date of birth';
    else
        insert into car_owner values (default, name, birthdate, passnum) returning id into result;
    end if;
    return result;
end;
$$;

-- Добавить паспорт ТС, вернуть id
create or replace function add_passport(
    id_number integer,
    category varchar(255),
    tpe varchar(255),
    chassis integer,
    body integer,
    power integer,
    own_w integer,
    allowed_m integer,
    iss_year integer,
    ecology_cl integer
)
    returns integer
    language plpgsql
as
$$
declare
    result        integer;
    declare sgn   integer;
    declare idnum integer;
begin
    assert id_number > 0
        and chassis > 0
        and body > 0
        and power > 0
        and own_w > 0 and allowed_m > 0 and ecology_cl > 0,
        'Domain data should be positive defined';

    assert iss_year >= 1900 and iss_year <= date_part('year', CURRENT_DATE), 'Incorrect issue year';

    if exists(
            select *
            from vehicle_passport
            where id_number = identification_number)
    then
        select id, identification_number
        from vehicle_passport
        where id_number = identification_number
        into result, sgn, idnum;

        assert idnum = id_number, 'Incompatible identification number';
    else
        insert into vehicle_passport
        values (default,
                id_number,
                category,
                tpe,
                chassis,
                body,
                power,
                own_w,
                allowed_m,
                iss_year,
                ecology_cl)
        returning id into result;
    end if;
    return result;
end;
$$;

-- Добавить страховой полис, вернуть id.
create or replace function add_insurance(strt date, finish date, owner_id integer, car_id integer)
    returns integer
    language plpgsql
as
$$
declare
    result integer;
begin
    -- assert exists(select * from car_owner where id = owner_id), 'Owner with given id does not exists';
    -- assert exists(select * from vehicle_passport where id = passport_id), 'Passport with given id does not exists';

    assert finish >= strt, 'Insurance end date cannot be lower than insurance start date';

    insert into insurance_policy
    values (default, strt, finish, owner_id, car_id)
    returning id into result;
    return result;
end;
$$;

-- Добавить ТС, вернуть id.
create or replace function add_vehicle(sign varchar(255), mdl varchar(255), clr varchar(255), ownr_id integer)
    returns integer
    language plpgsql
as
$$
declare
    result integer;
begin
    insert into vehicle
    values (default, sign, mdl, clr, ownr_id)
    returning id into result;
    return result;
end;
$$;

-- Вернуть статистику
drop type if exists stats cascade;
create type stats as
(
    cars           integer,
    owners         integer,
    passports      integer,
    policies       integer,
    certificates   integer,
    reg_applies    integer,
    theft_applies  integer,
    accident_cards integer
);

create or replace function get_stats()
    returns stats
    language plpgsql
as
$$
declare
    cars           integer;
    owners         integer;
    passports      integer;
    policies       integer;
    certificates   integer;
    reg_applies    integer;
    theft_applies  integer;
    accident_cards integer;
begin
    select count(*) from vehicle into cars;
    select count(*) from car_owner into owners;
    select count(*) from vehicle_passport into passports;
    select count(*) from insurance_policy into policies;
    select count(*) from registration_certificate into certificates;
    select count(*) from registration_application into reg_applies;
    select count(*) from theft_statement into theft_applies;
    select count(*) from accident_card into accident_cards;

    return (cars, owners, passports, policies, certificates, reg_applies, theft_applies, accident_cards);
end
$$;

-- Проверка совпадения пользовательских реквизитов и данных в базе.
create or replace function log_in(lgn varchar(255), pwd varchar(255))
    returns boolean
    language plpgsql
as
$$
begin
    return exists(select *
                  from credentials
                  where login = lgn
                    and password = pwd);
end;
$$;

-- Открыть/закрыть заявку на регистрацию
create or replace procedure check_application(app_id integer, open boolean)
    language plpgsql
as
$$
begin
    if open then
        update registration_application set status = 0 where id = app_id;
    else
        update registration_application set status = 1 where id = app_id;
    end if;
end;
$$;

-- Открыть/закрыть заявление об угоне
create or replace procedure check_application(app_id integer, open boolean)
    language plpgsql
as
$$
begin
    if open then
        update theft_statement set status = 0 where id = app_id;
    else
        update theft_statement set status = 1 where id = app_id;
    end if;
end;
$$;

-- В каких ДТП участвовала машина - возвращает список ДТП
create or replace function get_accidents_of_car(car_id integer)
    returns setof integer
    language plpgsql
as
$$
declare
    result integer;
begin
    for result in
        select a.id_accident_card
        from accident_participants a
        where a.id_vehicle = car_id
        loop
            return next result;
        end loop;
    return;
end;
$$;

-- Поиск ДТП, в которых участвовала машина, по модели и цвету машины
create or replace function get_accidents_of_car_by_properties(mdl varchar(255), clr varchar(255))
    returns setof integer
    language plpgsql
as
$$
declare
    result integer;
begin
    for result in
        select a.id_accident_card
        from accident_participants a,
             vehicle v
        where a.id_vehicle = v.id
          and (mdl is null or v.car_model = mdl)
          and (clr is null or v.color = clr)
        loop
            return next result;
        end loop;
    return;
end;
$$;

-- Добавить участников в карточку ДТП
create or replace procedure add_participants_to_accident(acc_id integer, variadic participants integer[])
language plpgsql
as
$$
declare
    p_id integer;
begin
    foreach p_id in array participants
        loop
            insert into accident_participants values (default, p_id, acc_id);
        end loop;
end;
$$;

-- Добавить заявление об угоне, вернуть id.
create or replace function add_theft_statement(ch text, det text, d date, owner_id integer, v_id integer,
                                               emp_id integer)
    returns integer
    language plpgsql
as
$$
declare
    result integer;
begin
    insert into theft_statement
    values (default, ch, det, d, 0, owner_id, v_id, emp_id)
    returning id into result;
    return result;
end;
$$;

-- Добавить заявку на регистрацию, вернуть id.
create or replace function add_reg_app(r_num integer, ch text, d date, owner_id integer, v_id integer, emp_id integer)
    returns integer
    language plpgsql
as
$$
declare
    result integer;
begin
    insert into registration_application
    values (default, r_num, ch, d, 0, owner_id, v_id, emp_id)
    returning id into result;
    return result;
end;
$$;

-- Добавить свидетельство о регистрации ТС, вернуть id.
create or replace function add_reg_certificate(num integer, d date, emp_id integer, own_id integer, app_id integer)
    returns integer
    language plpgsql
as
$$
declare
    result integer;
begin
    insert into registration_certificate
    values (default, num, d, emp_id, own_id, app_id)
    returning id into result;
    call check_application(app_id, false);
    return result;
end;
$$;

-- Добавить карточку ДТП, вернуть id.
create or replace function add_reg_app(d date, rsn text, tpe text, det text, emp_id integer)
    returns integer
    language plpgsql
as
$$
declare
    result integer;
begin
    insert into accident_card
    values (default, d, rsn, tpe, det, emp_id)
    returning id into result;
    return result;
end;
$$;
