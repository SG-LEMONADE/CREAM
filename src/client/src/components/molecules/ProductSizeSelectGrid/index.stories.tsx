import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import { action } from "@storybook/addon-actions";

import ProductSizeSelectGrid from ".";

export default {
	title: "molecules/ProductSizeSelectGrid",
	componsne: ProductSizeSelectGrid,
} as ComponentMeta<typeof ProductSizeSelectGrid>;

const Template: ComponentStory<typeof ProductSizeSelectGrid> = (args) => (
	<ProductSizeSelectGrid {...args}>{args.children}</ProductSizeSelectGrid>
);

export const ShoePrice = Template.bind({});
ShoePrice.args = {
	category: "price",
	activeSizeOption: "230",
	onClick: action("Activate Size Changes."),
	datas: [
		{
			lowest_95: null,
			option: "230",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: 240000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "235(US 4.5)",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: null,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "235(US 5)",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: 131000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "240(US 5.5)",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: null,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "240(US 6)",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: 170000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "245",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: 270000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "250",
			lowest_ask: 330000,
			lowest_normal: 330000,
			highest_bid: 245000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "255",
			lowest_ask: 265000,
			lowest_normal: 265000,
			highest_bid: 200000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "260",
			lowest_ask: 260000,
			lowest_normal: 260000,
			highest_bid: 215000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "265",
			lowest_ask: 270000,
			lowest_normal: 270000,
			highest_bid: 230000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "270",
			lowest_ask: 255000,
			lowest_normal: 255000,
			highest_bid: 223000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "275",
			lowest_ask: 260000,
			lowest_normal: 260000,
			highest_bid: 151000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "280",
			lowest_ask: 305000,
			lowest_normal: 305000,
			highest_bid: 250000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "285",
			lowest_ask: 420000,
			lowest_normal: 420000,
			highest_bid: 250000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "290",
			lowest_ask: 498000,
			lowest_normal: 498000,
			highest_bid: 225000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "295",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: 200000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "300",
			lowest_ask: 250000,
			lowest_normal: 250000,
			highest_bid: 200000,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "305",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: null,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "310",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: null,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "315",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: null,
			lowest_100: null,
		},
		{
			lowest_95: null,
			option: "320",
			lowest_ask: null,
			lowest_normal: null,
			highest_bid: null,
			lowest_100: null,
		},
	],
};

export const ProductWish = Template.bind({});
ProductWish.args = {
	category: "wish",
	activeSizeOption: ["240", "250", "270"],
	onClick: action("cliked"),
	datas: [
		"220",
		"225",
		"230",
		"235",
		"240",
		"245",
		"250",
		"255",
		"260",
		"265",
		"270",
		"275",
		"280",
		"285",
		"290",
	],
};
