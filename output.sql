BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "auth_permission" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "content_type_id" integer NOT NULL,
    "codename" varchar(100) NOT NULL,
    UNIQUE ("content_type_id", "codename")
);
INSERT INTO auth_permission VALUES(1,'Can add permission',1,'add_permission');
INSERT INTO auth_permission VALUES(2,'Can change permission',1,'change_permission');
INSERT INTO auth_permission VALUES(3,'Can delete permission',1,'delete_permission');
INSERT INTO auth_permission VALUES(4,'Can add group',2,'add_group');
INSERT INTO auth_permission VALUES(5,'Can change group',2,'change_group');
INSERT INTO auth_permission VALUES(6,'Can delete group',2,'delete_group');
INSERT INTO auth_permission VALUES(7,'Can add user',3,'add_user');
INSERT INTO auth_permission VALUES(8,'Can change user',3,'change_user');
INSERT INTO auth_permission VALUES(9,'Can delete user',3,'delete_user');
INSERT INTO auth_permission VALUES(10,'Can add content type',4,'add_contenttype');
INSERT INTO auth_permission VALUES(11,'Can change content type',4,'change_contenttype');
INSERT INTO auth_permission VALUES(12,'Can delete content type',4,'delete_contenttype');
INSERT INTO auth_permission VALUES(13,'Can add session',5,'add_session');
INSERT INTO auth_permission VALUES(14,'Can change session',5,'change_session');
INSERT INTO auth_permission VALUES(15,'Can delete session',5,'delete_session');
INSERT INTO auth_permission VALUES(16,'Can add site',6,'add_site');
INSERT INTO auth_permission VALUES(17,'Can change site',6,'change_site');
INSERT INTO auth_permission VALUES(18,'Can delete site',6,'delete_site');
INSERT INTO auth_permission VALUES(19,'Can add todo item',7,'add_todoitem');
INSERT INTO auth_permission VALUES(20,'Can change todo item',7,'change_todoitem');
INSERT INTO auth_permission VALUES(21,'Can delete todo item',7,'delete_todoitem');
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "group_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("group_id", "permission_id")
);
CREATE TABLE IF NOT EXISTS "auth_group" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(80) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id"),
    UNIQUE ("user_id", "group_id")
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("user_id", "permission_id")
);
CREATE TABLE IF NOT EXISTS "auth_user" (
    "id" integer NOT NULL PRIMARY KEY,
    "password" varchar(128) NOT NULL,
    "last_login" date NOT NULL,
    "is_superuser" bool NOT NULL,
    "username" varchar(30) NOT NULL UNIQUE,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "date_joined" date NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    UNIQUE ("app_label", "model")
);
INSERT INTO django_content_type VALUES(1,'permission','auth','permission');
INSERT INTO django_content_type VALUES(2,'group','auth','group');
INSERT INTO django_content_type VALUES(3,'user','auth','user');
INSERT INTO django_content_type VALUES(4,'content type','contenttypes','contenttype');
INSERT INTO django_content_type VALUES(5,'session','sessions','session');
INSERT INTO django_content_type VALUES(6,'site','sites','site');
INSERT INTO django_content_type VALUES(7,'todo item','todo_backend_django','todoitem');
CREATE TABLE IF NOT EXISTS "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" date NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_site" (
    "id" integer NOT NULL PRIMARY KEY,
    "domain" varchar(100) NOT NULL,
    "name" varchar(50) NOT NULL
);
INSERT INTO django_site VALUES(1,'example.com','example.com');
CREATE TABLE IF NOT EXISTS "todo_backend_django_todoitem" (
    "id" integer NOT NULL PRIMARY KEY,
    "title" varchar(256),
    "completed" bool,
    "url" varchar(256),
    "order" integer
);
INSERT INTO todo_backend_django_todoitem VALUES(1,'blah',false,'http://localhost:8000/todo/1',523);
INSERT INTO todo_backend_django_todoitem VALUES(2,'blah',false,'http://localhost:8000/todo/2',95);
INSERT INTO todo_backend_django_todoitem VALUES(3,'blah',false,'http://localhost:8000/todo/3',95);
CREATE INDEX "auth_permission_37ef4eb4" ON "auth_permission" ("content_type_id");
CREATE INDEX "auth_group_permissions_5f412f9a" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_83d7f98b" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_user_groups_6340c63c" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_5f412f9a" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_user_user_permissions_6340c63c" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_83d7f98b" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "django_session_b7b81f0c" ON "django_session" ("expire_date");
COMMIT;
