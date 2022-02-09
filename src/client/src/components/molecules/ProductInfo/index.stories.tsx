import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductInfo from "./";

export default {
	title: "Molecules/ProductInfo",
	component: ProductInfo,
} as ComponentMeta<typeof ProductInfo>;

const Template: ComponentStory<typeof ProductInfo> = (args) => (
	<ProductInfo {...args}>{args.children}</ProductInfo>
);

export const Home = Template.bind({});
Home.args = {
	category: "home",
	productInfo: {
		id: "1",
		originalName: "Jordan 1 Retro High OG Black Mocha",
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
		backgroundColor: "blue",
		brandName: "Jordan",
		imageUrls: "www.naver.com",
	},
};

export const Shop = Template.bind({});
Shop.args = {
	category: "shop",
	productInfo: {
		id: "1",
		originalName: "Jordan 1 Retro High OG Black Mocha",
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
		backgroundColor: "blue",
		brandName: "Jordan",
		imageUrls: "www.naver.com",
	},
};

export const Product = Template.bind({});
Product.args = {
	category: "product",
	productInfo: {
		id: "1",
		originalName: "Jordan 1 Retro High OG Black Mocha",
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
		backgroundColor: "blue",
		brandName: "Jordan",
		imageUrls: "www.naver.com",
	},
};
