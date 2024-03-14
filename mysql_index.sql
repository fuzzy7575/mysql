/* INDEX */

create table phone (
	phone_code int primary key,
    phone_name varchar(100),
    phone_price decimal(10,2)
);

insert into phone (phone_code, phone_name,phone_price)
values (1, 'galaxyS24', 1200000),
	   (2, 'iPhone15', 1400000),
       (3, 'galaxyZfold5', 2300000);
       
select * from phone;

-- EXPLAIN : 쿼리 실행 계획 확인 명령문
explain select * from phone
where phone_name = 'galaxyS24';

create index idx_name
on phone (phone_name);

create index idx_name_price
on phone (phone_name, phone_price);

show index from phone;

select * from phone
where phone_name = 'iPhone15';

explain select * from phone
where phone_name = 'iPhone15';

-- 인덱스 최적화(재구성)
-- 인덱스가 파편화 되었거나, 데이터의 대부분이 변경된 경우 유용하다.
-- 인덱스의 성능을 개선하고, 디스크 공간을 더 효율적으로 사용하게 한다.
-- 단, 재구성 하는동안 테이블은 잠겨 있을 수 있다. 주의해서 사용하기!
-- ALTER TABLE 명령어 사용해서 재구성한다.

alter table phone drop index idx_name;
alter table phone add index idx_name(phone_name);

optimize table phone;

drop index idx_name on phone;
show index from phone;
