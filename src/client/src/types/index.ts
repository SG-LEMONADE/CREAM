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
	imageUrls: string[];
	lowestAsk: number;
	originalName: string;
	originalPrice: number;
	premiumPrice: number;
	releasedDate: string;
	sizes: string[];
	styleCode: string;
	totalSale: number;
	translatedName: string;
	wishCnt: number;
	wishList: string[];
}

export interface HomeRes {
	adImageUrl: string[];
	sections: {
		header: string;
		detail: string;
		imageUrl: string;
		products: HomeProductInfoRes[];
	}[];
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

export interface UserInfo {
	id: number;
	email: string;
	name: null | string;
	adress: null | string;
	gender: null | string;
	age: null | number;
	shoeSize: number;
	profileImageUrl: string;
	status: number;
	passwordChangedDateTime: string;
	lastLoginDateTime: string;
	createdAt: string;
	updatedAt: null | string;
}

export interface TradeHistoryRes {
	counter: {
		totalCnt: number;
		waitingCnt: number;
		inProgressCnt: number;
		finishedCnt: number;
	};
	trades: TradeHistory[];
}

interface TradeHistory {
	backgroundColor: string;
	imageUrl: string;
	name: string;
	size: string;
	tradeStatus: string;
	updateDateTime: string;
	validationDate: string;
}
