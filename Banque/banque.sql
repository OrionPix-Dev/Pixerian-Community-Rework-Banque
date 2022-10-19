
DROP TABLE IF EXISTS `banque_historique`;
CREATE TABLE IF NOT EXISTS `banque_historique` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` text NOT NULL,
  `amount` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `date` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
