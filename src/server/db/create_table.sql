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

CREATE TABLE `product` (
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `original_name` varchar(225) NOT NULL,
                           `translated_name` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                           `original_price` int NOT NULL DEFAULT '0',
                           `gender` tinyint(1) NOT NULL DEFAULT '1',
                           `category` varchar(30) NOT NULL,
                           `color` varchar(15) NOT NULL,
                           `style_code` varchar(45) NOT NULL,
                           `wish_cnt` int NOT NULL DEFAULT '0',
                           `collection_id` bigint DEFAULT NULL,
                           `brand_id` bigint NOT NULL,
                           `brand_name` varchar(45) NOT NULL,
                           `background_color` varchar(45) NOT NULL,
                           `image_urls` json DEFAULT NULL COMMENT 'url값들이 들어가 있습니다.',
                           `released_date` date NOT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='상품 테이블';
