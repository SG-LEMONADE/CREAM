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

export interface WishProductsRes {
	backgroundColor: string;
	brandName: string;
	id: number;
	imageUrls: string[];
	lowestAsk: number;
	originalName: string;
	size: string;
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
	adImageUrls: {
		backgroundColor: string;
		imageUrl: string;
	}[];
	sections: {
		backgroundColor: string;
		detail: string;
		header: string;
		imageUrl: string;
		products: HomeProductInfoRes[];
	}[];
	recommendedItems: HomeProductInfoRes[];
}

export interface ProductRes {
	product: ProductInfoRes;
	lastCompletedTrades: {
		price: number;
		size: string;
		tradeDate: string;
	}[];
	asksBySizeCount: any[];
	bidsBySizeCount: any[];
	lastSalePrice: null | number;
	changePercentage: null | number;
	changeValue: null | number;
	pricePremiumPercentage: null | number;
	askPrices: any;
	bidPrices: any;
	relatedProducts: ProductInfoRes[];
}

export interface GetProductWishRes {
	count: number;
	products: WishProductsRes[];
}

export interface ShortcutItemRes {
	link: string;
	bigImg: string;
	smallImg: string;
	title: string;
}

export interface GraphDataItem {
	date: string;
	price: number;
}

export interface GraphData {
	oneMonth: GraphDataItem[];
	threeMonth: GraphDataItem[];
	sixMonth: GraphDataItem[];
	oneYear: GraphDataItem[];
	total: GraphDataItem[];
}

export interface UserInfo {
	id: number;
	email: string;
	name: null | string;
	address: null | string;
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
	trades: TradeHistoryItemRes[];
}

export interface TradeHistoryItemRes {
	backgroundColor: string;
	id: number;
	imageUrl: string[];
	name: string;
	size: string;
	price: number;
	productId: number;
	tradeStatus: string;
	updateDateTime: string;
	validationDate: string;
}
