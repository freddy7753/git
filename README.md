# Домашнее задание к занятию "`SQL. Часть 2`" - `Наурзгалиев Фарид`

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
Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию:

фамилия и имя сотрудника из этого магазина;
город нахождения магазина;
количество пользователей, закреплённых в этом магазине.
```

```sql
SELECT CONCAT(s2.first_name, ' ', s2.last_name) AS name, c.city, COUNT(c2.customer_id) AS customers_count
FROM store s
INNER JOIN staff s2 ON s.store_id = s2.store_id
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN customer c2 ON s.store_id  = c2.store_id
GROUP BY s2.first_name, s2.last_name, c.city
HAVING COUNT(c2.customer_id) > 300;

name        |city      |customers_count|
------------+----------+---------------+
Mike Hillyer|Lethbridge|            326|
```

---

### Задание 2

```sh
Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.
```

```sql
SELECT COUNT(1) AS count_of_movies
FROM film f
WHERE (SELECT AVG(f2.`length`) FROM film f2) < f.`length` ;

count_of_movies|
---------------+
            489|
```

---

### Задание 3

```
Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.
```

```sql
SELECT DATE_FORMAT(p.payment_date, '%Y-%m') AS month, COUNT(p.rental_id) AS rental_count, SUM(p.amount) AS total_amount
FROM payment p
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m')
HAVING SUM(p.amount) = (
	SELECT
		MAX(monthly_total)
	FROM (
		SELECT
			SUM(p2.amount) AS monthly_total
		FROM
			payment p2
		GROUP BY
			DATE_FORMAT(p2.payment_date, '%Y-%m')
		) AS monthly_totals
) ;

month  |rental_count|total_amount|
-------+------------+------------+
2005-07|        6709|    28368.91|
```

### Задание 4

```
Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».
```

```sql
SELECT COUNT(p.payment_date) AS payments_count,
	CASE
		WHEN COUNT(p.payment_date) > 8000 THEN 'Да'
		WHEN COUNT(p.payment_date) < 8000 THEN 'Нет'
	END AS 'Премия'
FROM payment p
INNER JOIN staff s on s.staff_id = p.staff_id
GROUP BY s.staff

payments_count|Премия|
--------------+------+
          8054|Да    |
          7990|Нет   |
```

### Задание 5

```
Найдите фильмы, которые ни разу не брали в аренду.
```

```sql
SELECT f.film_id, f.title
FROM film f
LEFT JOIN inventory i ON i.film_id  = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_id IS NULL;
```
