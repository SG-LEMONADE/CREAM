CREATE DATABASE `product_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `banner` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) NOT NULL,
  `valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `logo_image_url` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품의 브랜드들';

CREATE TABLE `collection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `brand_id` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='브랜드에서 만든 시리즈 테이블';

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
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품별 가격 변동 사항 및 현재 가격';

CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `original_name` varchar(225) NOT NULL,
  `translated_name` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `original_price` int NOT NULL DEFAULT '0',
  `gender` varchar(30) NOT NULL DEFAULT '',
  `category` varchar(30) NOT NULL,
  `color` varchar(100) DEFAULT '',
  `style_code` varchar(45) NOT NULL,
  `wish_cnt` int NOT NULL DEFAULT '0',
  `collection_id` bigint DEFAULT NULL,
  `brand_id` bigint NOT NULL,
  `brand_name` varchar(45) NOT NULL,
  `background_color` varchar(45) NOT NULL,
  `image_urls` json DEFAULT NULL COMMENT 'url값들이 들어가 있습니다.',
  `sizes` json DEFAULT NULL,
  `released_date` date DEFAULT NULL,
  `total_sale` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1592 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품 테이블';

CREATE TABLE `section` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `header` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `detail` text NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `filter_info` json NOT NULL,
  `valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `trade` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `size` varchar(20) NOT NULL,
  `request_type` tinyint NOT NULL COMMENT '0: 판매 요청\n1: 구매 요청',
  `trade_status` int NOT NULL DEFAULT '0' COMMENT '0: 대기 상태\\n1: 거래 진행\\n2: 거래 완료 상태\\n3: 요청 유효 기간 만료 4: 유저 등록 취소',
  `price` int NOT NULL,
  `validation_date_time` datetime DEFAULT NULL,
  `counterpart_user_id` bigint DEFAULT NULL COMMENT '구매 또는 판매에 응한 유저',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `wish` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `size` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='찜';


insert into banner (image_url, valid) values ("https://kream-phinf.pstatic.net/MjAyMjAxMjhfMjk0/MDAxNjQzMzM5MjYzODU1.cdlMQx38vTgTq7Gv7x6aUUtInzvEE_dzkyl4nNA2NwYg.W771A2Ma7g0bdKe9V_vTjBAbVDorcXhpqJp4bP2Aemsg.PNG/a_84e730df26b0461a958b47a868a6e047.png?type=m_2560", true);
insert into banner (image_url, valid) values ("https://kream-phinf.pstatic.net/MjAyMjAxMjhfMTEz/MDAxNjQzMzYwMDg5Njky.l6Xoov3_JXNKWYCBO5IxjNzmBDe1svKsqUB7NBcqthQg.ypkLxb2fdiX2julTL1GkUh51WH-AykkdXmvPt4_0tTIg.PNG/a_2985d4ae2e95457e9f4fa7940d926275.png?type=m_2560", true);
insert into banner (image_url, valid) values ("https://kream-phinf.pstatic.net/MjAyMjAxMjRfMTA5/MDAxNjQzMDE3MDM3MTUx.7WuV7cc0OdyV9CRmsM4ZA8e1cEIah2Igj-qiwDSAGwMg.DrBDw1BtjLqZe0FMWjO7XCiX_KycIGf_aOBmbXRz6ugg.JPEG/a_8cc13b5a8004402ba64b9a5451b771ff.jpg?type=m_2560", true);
insert into banner (image_url, valid) values ("https://kream-phinf.pstatic.net/MjAyMjAxMjBfMzIg/MDAxNjQyNjc1MzU0MDk5.uD7UAj_LBd8gtNrSgIT0tq6t0EnKPCmsf7NRSdwXdwsg.ldNON-DwpuG0HUyDdc4LVUtDIAmbbl9UvFVsad0EVyMg.PNG/a_38b058c0b5e74e8cb58e809f68457300.png?type=m_2560", true);

insert into section (header, detail, image_url, filter_info, valid) values ("Knit Collection", "겨울-봄까지! 활용도 높은 니트", "https://kream-phinf.pstatic.net/MjAyMjAxMjhfMjE4/MDAxNjQzMzYzODkyNTE2._6eteKF4YYSoOvklrXPV2aUC8lIgxukIVn1-ys5qNywg.jUAhXsyVVDESEBIYisTgiWD54D_7_WQYxMrW9Ikojq8g.PNG/a_bf4b1b7bfa24406c96cf9a8d0157a046.png?type=m_2560", '{"keyword": "knit",  "category": "streetwear"}', true);
insert into section (header, detail, image_url, filter_info, valid) values ("Luxury HeadWear", "머리 위의 럭셔리 포인트", "https://kream-phinf.pstatic.net/MjAyMjAxMjhfMTU1/MDAxNjQzMzY0Njg0ODk4.YuiYF6hambi1N0wqkrR9MMPCz7wLKwrCA2GTteD3gj4g.LHWfM_YB3DBCqTbnQrZgsluUOTgsnF_7kUK2JaTwJ4sg.PNG/a_2868f2d7671a4fa6b573f868e74a1943.png?type=m_2560", '{"keyword": "hat", "category": "accessories" }', true);
