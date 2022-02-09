import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";

import ProductThumbnail from "./";

export default {
	title: "organisms/ProductThumbnail",
	component: ProductThumbnail,
} as ComponentMeta<typeof ProductThumbnail>;

const Template: ComponentStory<typeof ProductThumbnail> = (args) => (
	<ProductThumbnail {...args} />
);

export const Home = Template.bind({});
Home.args = {
	category: "home",
	productInfo: {
		backgroundColor: "#f4f4f4",
		brandName: "Polo Ralph Lauren",
		category: "streetwear",
		color: "gray",
		gender: "unisex",
		highestBid: 1,
		id: 1,
		imageUrls: [
			"https://kream-phinf.pstatic.net/MjAyMjAxMDNfMjQ2/MDAxNjQxMTk0MTU4OTAz.iFlWZXvdVdxBfXDPR0WzCjLc016PYLPkRNoWNJX-Dcog.ZtfkW_G4T1wdsSPjLfA7HeoV5Fy2NOg0nq4BH5cldUAg.PNG/a_463faa3f82be472484727d084992bf62.png?type=m",
		],
		lowestAsk: 1,
		originalName: "Polo Ralph Lauren Cable Knit Cotton Sweater Grey",
		originalPrice: 200000,
		premiumPrice: 200000,
		releasedDate: "20200110",
		sizes: "",
		styleCode: "",
		totalSale: 1,
		translatedName: "어쩌구",
		wishCnt: 12,
		wishList: ["1"],
	},
	isWishState: true,
};

export const Shop = Template.bind({});
Shop.args = {
	category: "shop",
	productInfo: {
		id: "1",
		name: "Jordan 1 Retro High OG Black Mocha",
		translatedName: "조던 1 레트로 하이 OG 블랙 모카",
		originalPrice: 230000,
		color: "red",
		releasedDate: "20200101",
		gender: "male",
		category: "shoe",
		styleCode: 1,
		wishCnt: 12,
		collectionId: "1",
		brandId: "1",
		backgroundColor: "#f6eeed",
		brandName: "Jordan",
		imageUrls: [
			"https://kream-phinf.pstatic.net/MjAyMDEwMjJfOCAg/MDAxNjAzMzQwOTUzNzMx.nCU7Bumo43r7JZcTRjq4blFOcj33dPIxNYW-_94RtWgg.rJwsoEL3W-f7pgpwfYISb-0HBItIWL04h7p8Ixyp8CUg.PNG/p_4cedd884b4a3427ca616bc31b3bf2867.png?type=m",
		],
	},
	isWishState: true,
};

export const Products = Template.bind({});
Products.args = {
	category: "products",
	productInfo: {
		id: "1",
		name: "Jordan 1 Retro High OG Black Mocha",
		translatedName: "조던 1 레트로 하이 OG 블랙 모카",
		originalPrice: 230000,
		color: "red",
		releasedDate: "20200101",
		gender: "male",
		category: "shoe",
		styleCode: 1,
		wishCnt: 12,
		collectionId: "1",
		brandId: "1",
		backgroundColor: "#f6eeed",
		brandName: "Jordan",
		imageUrls: [
			"https://kream-phinf.pstatic.net/MjAyMDEwMjJfOCAg/MDAxNjAzMzQwOTUzNzMx.nCU7Bumo43r7JZcTRjq4blFOcj33dPIxNYW-_94RtWgg.rJwsoEL3W-f7pgpwfYISb-0HBItIWL04h7p8Ixyp8CUg.PNG/p_4cedd884b4a3427ca616bc31b3bf2867.png?type=m",
		],
	},
};
