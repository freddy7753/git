# Домашнее задание к занятию "`Система мониторинга Zabbix`" - `Наурзгалиев Фарид`

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

![скрин 1](https://github.com/freddy7753/git/blob/main/img/img28.png)

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6.

```
# sudo apt install postgresql
# wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
# dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
# apt update
# apt install zabbix-server-pgsql zabbix-frontend-php php8.1-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent
# sudo -u postgres createuser --pwprompt zabbix
# sudo -u postgres createdb -O zabbix zabbix
# zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
DBPassword=password
# systemctl restart zabbix-server zabbix-agent apache2
# systemctl enable zabbix-server zabbix-agent apache2

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`

---

### Задание 2

![скрин 1](https://github.com/freddy7753/git/blob/main/img/img29.png)
![скрин 1](https://github.com/freddy7753/git/blob/main/img/img30.png)
![скрин 1](https://github.com/freddy7753/git/blob/main/img/img31.png)
![скрин 1](https://github.com/freddy7753/git/blob/main/img/img32.png)
![скрин 1](https://github.com/freddy7753/git/blob/main/img/img33.png)

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6.

```
 51  sudo apt update
   52  wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
   53  ls
   54  dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
   55  sudo dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
   56  sudo apt update
   57  sudo apt install zabbix-agent
   58  sudo systemctl restart zabbix-agent
   59  sudo systemctl enable zabbix-agent
   60  sudo systemctl status zabbix-agent
   61  sudo find / -name zabbix_agentd.conf
   62  sudo nano /etc/zabbix/zabbix_agentd.conf
   63  sudo apt install nano
   64  sudo nano /etc/zabbix/zabbix_agentd.conf
   65  sudo tail -f /var/log/zabbix/zabbix_agentd.log
   66  sudo systemctl restart zabbix-agentd.service
   67  sudo systemctl restart zabbix-agent.service
   68  sudo systemctl status zabbix-agent.service
   69  sudo locale -a
   70  sudo locale-gen en_US.UTF-8
   71  sudo dpkg-reconfigure locales
   72  sudo cat /usr/share/i18n/SUPPORTED | grep en_US*
   73  sudo apt-get update
   74  sudo apt i locales
   75  sudo apt install locales
   76  sudo locale-gen en_US.UTF-8
   77  sudo dpkg-reconfigure locales
   78  sudo service apache2 restart
   79  sudo systemctl restart apache2
   80  sudo systemctl restart apache2.service
   81  sudo systemctl restart apache
   82  sudo systemctl status apache2
   83  history
   84  sudo find / -name zabbix_agentd.conf
   85  sudo find / -name zabbix_agentd.log
   86  tail -help
   87  tail --help
   88  sudo find / -name zabbix_agentd.log
   89  tail -f /var/log/zabbix/zabbix_agentd.log
   90  sudo find / -name zabbix_agentd.conf
   91  sudo nano /etc/zabbix/zabbix_agentd.conf
   92  sudo systemctl restart zabbix-agent
   93  sudo systemctl status zabbix-agent
   94  cat /var/log/zabbix/zabbix_agentd.log


```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 2](ссылка на скриншот 2)`

---

### Задание 3

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6.

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`

### Задание 4

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6.

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`
