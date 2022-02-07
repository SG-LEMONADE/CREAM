export interface ProductInfoRes {
	id: number;
	originalName: string;
	translatedName: string;
	originalPrice: number;
	gender: string;
	category: string;
	color: string;
	styleCode: string;
	wishCnt: number;
	brandName: string;
	backgroundColor: string;
	imageUrls: string[];
	sizes: string[];
	releasedDate: string;
	totalSale: number;
	wishList: null | string[];
	lowestAsk: null;
	highestBid: null;
	premiumPrice: null;
}

export interface HomeProductInfoRes {
	backgroundColor: string;
	brandName: string;
	category: string;
	color: string;
	gender: string;
	highestBid: number;
	id: number;
	imageUrls: string;
	lowestAsk: number;
	originalName: string;
	originalPrice: number;
	premiumPrice: number;
	releasedDate: string;
	sizes: string;
	styleCode: string;
	totalSale: number;
	translatedName: string;
	wishCnt: number;
	wishList: string[];
}

export interface ShortcutItemRes {
	link: string;
	bigImg: string;
	smallImg: string;
	title: string;
}

export interface SalesOptionsRes {
	lowest_95: null | string;
	option: string;
	lowest_ask: null | number;
	lowest_normal: null | number;
	highest_bid: null | number;
	lowest_100: null | number;
}
