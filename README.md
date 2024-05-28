# Домашнее задание к занятию "`Индексы`" - `Наурзгалиев Фарид`

### Инструкция по выполнению домашнего задания

1.  Сделайте `fork` данного репозитория к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/git-hw или https://github.com/имя-вашего-репозитория/7-1-ansible-hw).
2.  Выполните клонирование данного репозитория к себе на ПК с помощью команды `git clone`.
3.  Выполните домашнее задание и заполните у себя локально этот файл README.md:
    - впишите вверху название занятия и вашу фамилию и имя
    - в каждом задании добавьте решение в требуемом виде (текст/код/скриншоты/ссылка)
    - для корректного добавления скриншотов воспользуйтесь [инструкцией "Как вставить скриншот в шаблон с решением](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md)
    - при оформлении используйте возможности языка разметки md (коротко об этом можно посмотреть в [инструкции по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md))
4.  После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`);
5.  Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
6.  Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.

Желаем успехов в выполнении домашнего задания!

### Дополнительные материалы, которые могут быть полезны для выполнения задания

1. [Руководство по оформлению Markdown файлов](https://gist.github.com/Jekins/2bf2d0638163f1294637#Code)

---

### Задание 1

```
Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.
```

### Решение 1

```sql
SELECT ROUND((SUM(INDEX_LENGTH) / SUM(DATA_LENGTH)) * 100) percent
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'sakila';

percent|
-------+
     53|
```

---

### Задание 2

```sh
Выполните explain analyze следующего запроса:
```

```sql
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```

```
перечислите узкие места;
оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.
```

### Решение 2

```sql
EXPLAIN ANALYZE
select distinct
	concat(c.last_name, ' ', c.first_name),
	sum(p.amount) over (partition by c.customer_id, f.title)
from
	payment p,
	rental r,
	customer c,
	inventory i,
	film f
where
	date(p.payment_date) = '2005-07-30'
	and p.payment_date = r.rental_date
	and r.customer_id = c.customer_id
	and i.inventory_id = r.inventory_id;


-> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=2730..2730 rows=391 loops=1)
    -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=2730..2730 rows=391 loops=1)
        -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=1238..2632 rows=642000 loops=1)
            -> Sort: c.customer_id, f.title  (actual time=1238..1276 rows=642000 loops=1)
                -> Stream results  (cost=22.6e+6 rows=16.5e+6) (actual time=0.258..959 rows=642000 loops=1)
                    -> Nested loop inner join  (cost=22.6e+6 rows=16.5e+6) (actual time=0.255..830 rows=642000 loops=1)
                        -> Nested loop inner join  (cost=20.9e+6 rows=16.5e+6) (actual time=0.252..715 rows=642000 loops=1)
                            -> Nested loop inner join  (cost=19.3e+6 rows=16.5e+6) (actual time=0.248..598 rows=642000 loops=1)
                                -> Inner hash join (no condition)  (cost=1.65e+6 rows=16.5e+6) (actual time=0.239..22.7 rows=634000 loops=1)
                                    -> Filter: (cast(p.payment_date as date) = '2005-07-30')  (cost=1.72 rows=16500) (actual time=0.0172..3.02 rows=634 loops=1)
                                        -> Table scan on p  (cost=1.72 rows=16500) (actual time=0.0112..2.26 rows=16044 loops=1)
                                    -> Hash
                                        -> Covering index scan on f using idx_title  (cost=112 rows=1000) (actual time=0.0251..0.134 rows=1000 loops=1)
                                -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=0.969 rows=1) (actual time=624e-6..819e-6 rows=1.01 loops=634000)
                            -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=250e-6 rows=1) (actual time=78.6e-6..94.9e-6 rows=1 loops=642000)
                        -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=250e-6 rows=1) (actual time=74.9e-6..91.2e-6 rows=1 loops=642000)



SELECT DISTINCT
	CONCAT(c.last_name, ' ', c.first_name) name,
	SUM(p.amount) amount
FROM
	payment p
	JOIN rental r ON r.rental_id = p.rental_id
	JOIN customer c ON c.customer_id = r.customer_id
	JOIN inventory i ON r.inventory_id = i.inventory_id
	JOIN film f ON i.film_id = f.film_id
WHERE
	p.payment_date >= '2005-07-30 00:00:00'
	AND p.payment_date < '2005-07-31 00:00:00'
	AND p.payment_date = r.rental_date
GROUP BY name;

-> Table scan on <temporary>  (actual time=4.14..4.18 rows=391 loops=1)
    -> Aggregate using temporary table  (actual time=4.14..4.14 rows=391 loops=1)
        -> Nested loop inner join  (cost=1023 rows=31.7) (actual time=0.0353..3.75 rows=634 loops=1)
            -> Nested loop inner join  (cost=795 rows=634) (actual time=0.0252..2.26 rows=634 loops=1)
                -> Nested loop inner join  (cost=573 rows=634) (actual time=0.022..1.58 rows=634 loops=1)
                    -> Nested loop inner join  (cost=351 rows=634) (actual time=0.0187..0.893 rows=634 loops=1)
                        -> Filter: ((r.rental_date >= TIMESTAMP'2005-07-30 00:00:00') and (r.rental_date < TIMESTAMP'2005-07-31 00:00:00'))  (cost=129 rows=634) (actual time=0.012..0.231 rows=634 loops=1)
                            -> Covering index range scan on r using rental_date over ('2005-07-30 00:00:00' <= rental_date < '2005-07-31 00:00:00')  (cost=129 rows=634) (actual time=0.011..0.17 rows=634 loops=1)
                        -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.25 rows=1) (actual time=929e-6..946e-6 rows=1 loops=634)
                    -> Single-row index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.25 rows=1) (actual time=961e-6..978e-6 rows=1 loops=634)
                -> Single-row covering index lookup on f using PRIMARY (film_id=i.film_id)  (cost=0.25 rows=1) (actual time=957e-6..974e-6 rows=1 loops=634)
            -> Filter: (p.payment_date = r.rental_date)  (cost=0.257 rows=0.05) (actual time=0.00192..0.0022 rows=1 loops=634)
                -> Index lookup on p using fk_payment_rental (rental_id=r.rental_id)  (cost=0.257 rows=1.03) (actual time=0.00181..0.00206 rows=1 loops=634)

Узкие места
- Вычисление оконной агрегатной функции sum(payment.amount) OVER (PARTITION BY c.customer_id, f.title) с буферизацией может быть ресурсоемким, особенно если объем данных велик. Это может привести к увеличению времени выполнения запроса.
- Операция сортировки (Sort: c.customer_id, f.title) необходима для правильного применения оконной функции. Однако сортировка больших объемов данных может быть дорогостоящей операцией с точки зрения производительности.
- Несколько вложенных циклов внутренних соединений (Nested loop inner join) указывают на то, что данные объединяются без использования индексов, что может существенно замедлить выполнение запроса, особенно при работе с большими объемами данных.
- Полные сканы таблиц (Table scan on p, Table scan on <temporary>) являются одними из самых затратных операций, поскольку они требуют чтения всего объема данных в таблице. Это может быть особенно проблематично для больших таблиц.
- Большое количество обработанных строк (rows=642000, rows=634000, rows=16044) указывает на то, что запрос обрабатывает большой объем данных, что само по себе может замедлять выполнение.
```

---
