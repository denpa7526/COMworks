# COMworksのテーブル設計

## Usersテーブル

| Column             | Type    | Options     |
|--------------------|---------|-------------|
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| username           | string  | null: false, unique: true |
| position           | string  | null: false |
| phone_number       | string  | null: false |
| role               | integer | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |

### Association

- has_secure_password
- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :messages


## AdminUsersテーブル

| Column             | Type    | Options     |
|--------------------|---------|-------------|
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| username           | string  | null: false, unique: true |
| company            | string  | null: false, unique: true |
| phone_number       | string  | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |

### Association

- has_secure_password
- has_one :shared_password


## SharedPasswordsテーブル

| Column          | Type       | Options     |
|-----------------|------------|-------------|
| password_digest | string     | null: false |
| admin_user      | references | null: false, foreign_key: true |

### Association

- belongs_to :admin_user
- has_secure_password


## Roomsテーブル

| Column     | Type       | Options     |
|------------|------------|-------------|
| name       | string     | null: false |
| room_type  | integer    | null: false |
| created_by | references | null: false, foreign_key: true |

### Association

- belongs_to :created_by, class_name: 'User'
- has_many :room_users, dependent: :destroy
- has_many :users, through: :room_users
- has_many :messages, dependent: :destroy


## RoomUsersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user


## Messagesテーブル

| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| content | text       |                                |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user
