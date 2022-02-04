export const category_id = {
	의류: "streetwear",
	스니커즈: "sneakers",
	"패션 잡화": "accessories",
	라이프: "life",
	테크: "electronics",
};

export const gender_id = {
	남성: "men",
	여성: "women",
	공용: "unisex",
};

export const priceRange = {
	"10만원 이하": {
		priceTo: 100000,
	},
	"10만원 ~ 30만원 이하": {
		priceFrom: 100000,
		priceTo: 300000,
	},
	"30만원 ~ 50만원 이하": {
		priceFrom: 300000,
		priceTo: 500000,
	},
	"50만원 이상": {
		priceFrom: 500000,
	},
};

export const sort_id = {
	인기순: "total_sale",
	"발매일 최신순": "released_date",
	프리미엄순: "premium_price",
	"즉시 구매가순": "lowest_ask",
	"즉시 판매가순": "highest_bid",
};
