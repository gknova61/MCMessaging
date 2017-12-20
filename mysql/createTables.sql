CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(200) DEFAULT NULL,
  `idFrom` varchar(45) DEFAULT NULL,
  `idTo` varchar(45) DEFAULT NULL,
  `timeSent` datetime DEFAULT CURRENT_TIMESTAMP,
  `accessed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` varchar(64) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `salt` varchar(10) DEFAULT NULL,
  `ip` varchar(40) DEFAULT NULL,
  `timeCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;