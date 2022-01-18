CREATE TABLE `user` (
                        `id` bigint NOT NULL AUTO_INCREMENT,
                        `email` varchar(50) NOT NULL,
                        `password` varchar(100) NOT NULL,
                        `name` varchar(20) NOT NULL,
                        `address` varchar(255) NOT NULL,
                        `gender` tinyint(1) NOT NULL,
                        `age` tinyint NOT NULL,
                        `shoe_size` int NOT NULL,
                        `profile_image_url` varchar(255) NOT NULL,
                        `status` tinyint NOT NULL DEFAULT '0' COMMENT '0 - 가입 신청 완료 \\n1 - 비밀번호를 반드시 변경해야 하는 회원 \\n 2 - 이메일 인증한 회원 \\n 3 - 삭제된 회원 ',
                        `password_changed_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `last_login_datetime` datetime DEFAULT NULL,
                        `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `update_at` datetime DEFAULT NULL,
                        PRIMARY KEY (`id`),
                        UNIQUE KEY `id_UNIQUE` (`id`),
                        UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE DATABASE `product_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE `brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `info` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품의 브랜드들';
CREATE TABLE `market` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `size` varchar(20) DEFAULT NULL,
  `change_percentage` float(10,3) NOT NULL DEFAULT '0.000' COMMENT '바로 직전 거래와 가격차이 퍼센트',
  `change_value` int NOT NULL DEFAULT '0' COMMENT '바로 직전 거래와 가격차이 ',
  `highest_bid` int NOT NULL DEFAULT '0' COMMENT '즉시 판매가',
  `last_sale_price` int NOT NULL DEFAULT '0' COMMENT '최근 거래가',
  `lowest_ask` int NOT NULL DEFAULT '0' COMMENT '즉시 구매가',
  `price_premium` int NOT NULL DEFAULT '0' COMMENT '최근 거래가 - 발매 가격',
  `price_premium_percentage` float(10,3) NOT NULL DEFAULT '0.000' COMMENT '발매 가격 대비 상승률',
  `total_sales` int NOT NULL DEFAULT '0' COMMENT '총 거래수',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품별 가격 변동 사항 및 현재 가격';
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `original_name` varchar(225) NOT NULL,
  `translated_name` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `original_price` int NOT NULL DEFAULT '0',
  `gender` tinyint(1) NOT NULL DEFAULT '1',
  `category` varchar(30) NOT NULL,
  `color` varchar(45) NOT NULL,
  `style_code` varchar(45) NOT NULL,
  `wish_cnt` int NOT NULL DEFAULT '0',
  `collection_id` bigint DEFAULT NULL,
  `brand_id` bigint NOT NULL,
  `brand_name` varchar(45) NOT NULL,
  `background_color` varchar(45) NOT NULL,
  `image_urls` json DEFAULT NULL COMMENT 'url값들이 들어가 있습니다.',
  `sizes` json DEFAULT NULL,
  `released_date` date DEFAULT NULL,
  `highest_bid` int NOT NULL DEFAULT '0' COMMENT '최대 즉시 판매가 (전체 사이즈)',
  `total_sale` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품 테이블';
CREATE TABLE `tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품에서 사용될 태그들';
CREATE TABLE `wish` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `size` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='찜';
