CREATE TABLE `User` (
  `username` varchar(50) UNIQUE NOT NULL,
  `born` date NOT NULL,
  `email` varchar(50) UNIQUE,
  `id` integer PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE `Studio` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(50),
  `description` text,
  `location` varchar(25),
  `founded` year,
  `avatar` blob,
  `is_deleted` timestamp DEFAULT null
);

CREATE TABLE `Guide` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(50),
  `description` text,
  `image_url` varchar(255),
  `game_id` integer,
  `last_updated_by` varchar(50) DEFAULT null,
  `last_updated_at` timestamp DEFAULT null
);

CREATE TABLE `User_Guide` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `created_by` integer,
  `guide_id` integer
);

CREATE TABLE `Library` (
  `user_id` integer,
  `game_id` integer,
  `purchase_date` timestamp NOT NULL,
  `method` varchar(25),
  `hours_played` decimal(5,1),
  PRIMARY KEY (`user_id`, `game_id`)
);

CREATE TABLE `CompanyManager` (
  `full_name` varchar(50),
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(50) UNIQUE,
  `position` varchar(50)
);

CREATE TABLE `SupportRequest` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `description` text,
  `created_at` timestamp NOT NULL,
  `manager_id` integer
);

CREATE TABLE `Review` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(25),
  `review` text,
  `rate` integer NOT NULL,
  `last_updated_by` varchar(50) DEFAULT null,
  `last_updated_at` timestamp DEFAULT null
);

CREATE TABLE `User_Review` (
  `user_id` integer,
  `review_id` integer,
  `publish_date` timestamp NOT NULL,
  `view_mode` ENUM ('Private', 'Public', 'Friends'),
  PRIMARY KEY (`user_id`, `review_id`)
);

CREATE TABLE `Item` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(25),
  `description` text,
  `price` decimal,
  `is_marketable` boolean,
  `is_tradable` boolean,
  `is_social` boolean,
  `game_id` integer
);

CREATE TABLE `Inventory` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `item_id` integer,
  `recieve_date` timestamp NOT NULL
);

CREATE TABLE `Character` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `full_name` varchar(100),
  `born` date NOT NULL
);

CREATE TABLE `CharacterRole` (
  `game_id` integer,
  `character_id` integer,
  `role_level` ENUM ('Antagonist', 'Protagonist', 'Deutragonist', 'Supporting', 'Minor'),
  `history` text NOT NULL,
  PRIMARY KEY (`game_id`, `character_id`)
);

CREATE TABLE `Achievment` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `img` blob NOT NULL,
  `desc` varchar(100),
  `game_id` integer
);

CREATE TABLE `User_Achievment` (
  `user_id` integer,
  `achievment_id` integer,
  `is_achieved` boolean DEFAULT false,
  `achieve_date` timestamp DEFAULT null,
  PRIMARY KEY (`user_id`, `achievment_id`)
);

CREATE TABLE `User_User` (
  `user1_id` integer,
  `user2_id` integer,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`user1_id`, `user2_id`)
);

CREATE TABLE `Game` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(40) UNIQUE NOT NULL,
  `created_at` year NOT NULL,
  `price` decimal,
  `desc` text,
  `studio_id` integer
);

CREATE TABLE `Language` (
  `language` varchar(25) NOT NULL,
  `id` integer PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE `Genre` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(50)
);

CREATE TABLE `Genre_Game` (
  `game_id` integer,
  `genre_id` integer,
  PRIMARY KEY (`game_id`, `genre_id`)
);

CREATE TABLE `Localization` (
  `game_id` integer NOT NULL,
  `language_id` integer NOT NULL,
  `audio` bool,
  `interface` bool,
  `subtitles` bool,
  PRIMARY KEY (`game_id`, `language_id`)
);

CREATE TABLE `GameAward` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `award_year` year,
  `game_id` integer
);

CREATE UNIQUE INDEX `Localization_index_0` ON `Localization` (`game_id`, `language_id`);

CREATE UNIQUE INDEX `GameAward_index_1` ON `GameAward` (`name`, `award_year`);

ALTER TABLE `Guide` ADD FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`);

ALTER TABLE `User_Guide` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);

ALTER TABLE `User_Guide` ADD FOREIGN KEY (`guide_id`) REFERENCES `Guide` (`id`);

ALTER TABLE `Library` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `Library` ADD FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`);

ALTER TABLE `SupportRequest` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `SupportRequest` ADD FOREIGN KEY (`manager_id`) REFERENCES `CompanyManager` (`id`);

ALTER TABLE `User_Review` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `User_Review` ADD FOREIGN KEY (`review_id`) REFERENCES `Review` (`id`);

ALTER TABLE `Item` ADD FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`);

ALTER TABLE `Inventory` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `Inventory` ADD FOREIGN KEY (`item_id`) REFERENCES `Item` (`id`);

ALTER TABLE `CharacterRole` ADD FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`);

ALTER TABLE `CharacterRole` ADD FOREIGN KEY (`character_id`) REFERENCES `Character` (`id`);

ALTER TABLE `Achievment` ADD FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`);

ALTER TABLE `User_Achievment` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `User_Achievment` ADD FOREIGN KEY (`achievment_id`) REFERENCES `Achievment` (`id`);

ALTER TABLE `User_User` ADD FOREIGN KEY (`user1_id`) REFERENCES `User` (`id`);

ALTER TABLE `User_User` ADD FOREIGN KEY (`user2_id`) REFERENCES `User` (`id`);

ALTER TABLE `Game` ADD FOREIGN KEY (`studio_id`) REFERENCES `Studio` (`id`);

ALTER TABLE `Genre_Game` ADD FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`);

ALTER TABLE `Genre_Game` ADD FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`id`);

ALTER TABLE `Localization` ADD FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`);

ALTER TABLE `Localization` ADD FOREIGN KEY (`language_id`) REFERENCES `Language` (`id`);

ALTER TABLE `GameAward` ADD FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`);
