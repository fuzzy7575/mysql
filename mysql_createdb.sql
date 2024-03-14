create user 'ohgiraffers'@'%' identified by 'ohgiraffers';
show databases;
use mysql;
select * From user;
create database menudb;
grant all privileges on menudb.* to 'ohgiraffers'@'%';
show grants for 'ohgiraffers'@'%';
use menudb;

create database employee;
grant all privileges on employee.* to 'ohgiraffers'@'%';
show grants for 'ohgiraffers'@'%';
use employee;

create database rpg;
grant all privileges on rpg.* to 'ohgiraffers'@'%';
show grants for 'ohgiraffers'@'%';
use rpg;