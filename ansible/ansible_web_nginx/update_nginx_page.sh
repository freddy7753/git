#!/bin/bash

# Путь к файлу, который нужно обновить
NGINX_INDEX="/var/www/html/index.nginx-debian.html"

# Новое содержимое страницы по умолчанию
cat <<EOF > $NGINX_INDEX
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Nginx!</title>
</head>
<body>
    <h1>Web server</h1>
    <p>Этот текст был изменен с помощью Ansible.</p>
</body>
</html>
EOF

# Перезапуск Nginx для применения изменений
systemctl restart nginx

# Вывод информации о состоянии Nginx
echo "Состояние Nginx:"
systemctl status nginx | grep "Active:"

# Вывод информации об открытых портах
echo "Открытые порты:"
ss -tuln | grep LISTEN

# Дополнительная информация о подключениях к Nginx (опционально)
echo "Подключения к Nginx:"
ss -tuln | grep ':80'