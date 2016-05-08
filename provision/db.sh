lineinfile: dest=/etc/mysql/my.cnf regexp="^bind-address" "line=#bind-address = 0.0.0.0"
  notify: restart mysql

- name: Create MySQL database symfony
  command: mysql -u root -e "CREATE DATABASE IF NOT EXISTS symfony;"

- name: Add symfony user allow connect from anywhere to MySQL
  command: mysql -u root -e "CREATE USER 'symfony'@'%' IDENTIFIED BY 'mysymfonydatabasepassword'; FLUSH PRIVILEGES;"

- name: Grant all privileges on symfony database
  command: mysql -u root -e "GRANT ALL PRIVILEGES ON symfony.* TO 'symfony'@'%'; FLUSH PRIVILEGES;"
