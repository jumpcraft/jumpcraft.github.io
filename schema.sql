DROP TABLE IF EXISTS `user_achievement`;
CREATE TABLE `user_achievement` (
  `id` varchar(128) NOT NULL,
  `achievement` varchar(256) NOT NULL,
  `done` boolean NOT NULL,
  PRIMARY KEY (`id`, `achievement`),
  KEY `done` (`done`),
  KEY `achievement` (`achievement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
  `username` varchar(128) NOT NULL,
  `groupname` varchar(128) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `user_ids`;
CREATE TABLE `user_ids` (
    `username` varchar(128) NOT NULL,
    `id` varchar(128) NOT NULL,
    PRIMARY KEY (`username`),
    UNIQUE (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `user_stat`;
CREATE TABLE `user_stat` (
  `id` varchar(128) NOT NULL,
  `category` varchar(126) NOT NULL,
  `stat` varchar(126) NOT NULL,
  `value` bigint(20) NOT NULL,
  PRIMARY KEY (`id`, `category`, `stat`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;