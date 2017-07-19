
CREATE DATABASE IF NOT EXISTS demo_project_development;
CREATE DATABASE IF NOT EXISTS demo_project_test;
CREATE DATABASE IF NOT EXISTS demo_project_production;
GRANT ALL PRIVILEGES ON demo_project_development.* TO 'user'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON demo_project_test.* TO 'user'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON demo_project_production.* TO 'user'@'%' WITH GRANT OPTION;
SHOW DATABASES ;
