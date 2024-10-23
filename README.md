# COMworksのテーブル設計

## Usersテーブル

| Column             | Type       | Options     |
|--------------------|------------|-------------|
| last_name          | string     | null: false |
| first_name         | string     | null: false |
| username           | string     | null: false, unique: true |
| position           | string     | null: false |
| phone_number       | string     | null: false |
| role               | integer    | null: false |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false |
| company            | references | null: false, foreign_key: true |

### Association

- has_secure_password
- has_one :admin_user
- belongs_to :company, optional: true
- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :messages


## AdminUsersテーブル

| Column          | Type       | Options     |
|-----------------|------------|-------------|
| last_name       | string     | null: false |
| first_name      | string     | null: false |
| phone_number    | string     | null: false |
| email           | string     | null: false, unique: true |
| password_digest | string     | null: false |
| user            | references | null: false, foreign_key: true |
| company         | references | null: false, foreign_key: true |

### Association

- has_secure_password
- belongs_to :user
- belongs_to :company


## SharedPasswordsテーブル

| Column          | Type       | Options     |
|-----------------|------------|-------------|
| password_digest | string     | null: false, unique: true |
| company         | references | null: false, foreign_key: true |

### Association

- has_secure_password
- belongs_to :company


## Companiesテーブル

| Column     | Type       | Options     |
|------------|------------|-------------|
| name       | string     | null: false, unique: true |

### Association

- has_many :users
- has_many :admin_users
- has_one :shared_password


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

- belongs_to :user
- belongs_to :room


## Messagesテーブル

| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| content | text       |                                |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user
