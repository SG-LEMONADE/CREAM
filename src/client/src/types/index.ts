export interface ProductInfoRes {
	id: string;
	name: string;
	translatedName: string;
	originalPrice: number;
	color: string;
	releasedDate: string;
	gender: string;
	category: string;
	styleCode: number;
	wishCnt: number;
	collectionId: string;
	brandId: string;
	backgroundColor: string;
	brandName: string;
	imageUrls: string;
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
