# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## UI設計
トップ画面
![トップ画面](https://github.com/KoosukeAbe/training/blob/KoosuleAbe_step4/taskkun/documents/Slide2.png)

タスク選択後の画面
![タスク選択画面](https://github.com/KoosukeAbe/training/blob/KoosuleAbe_step4/taskkun/documents/Slide3.png)

タスク新規作成画面
![タスク新規作成画面](https://github.com/KoosukeAbe/training/blob/KoosuleAbe_step4/taskkun/documents/Slide4.png)

## DB設計
E-R図
![E-R図](https://github.com/KoosukeAbe/training/blob/KoosuleAbe_step4/taskkun/documents/Slide5.png)

```
CREATE TABLE tasks
(
  id INT NOT NULL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  description VARCHAR(255),
  importance INT NOT NULL,
  due_date DATE NOT NULL,
  created_at DATETIME NOT NULL,
  user_id INT NOT NULL,
  status_id INT NOT NULL,
  label_id INT NOT NULL,
  is_deleted BOOLEAN NOT NULL,
);

CREATE TABLE users
(
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
);

CREATE TABLE statuses
(
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
);

CREATE TABLE labels
(
  id INT NOT NULL PRIMARY_KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
);
```

