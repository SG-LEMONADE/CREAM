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
		"모든 사이즈",
	],
	pricePerSize: {
		"220": 120000,
		"225": 125000,
		"230": 140000,
		"235": 130000,
		"240": 132000,
		"245": 110000,
		"250": null,
		"255": null,
		"260": 112000,
		"265": 120000,
		"270": null,
		"275": null,
		"280": null,
		"285": 140000,
		"290": 120000,
		"모든 사이즈": null,
	},
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

export const SizeOnly = Template.bind({});
SizeOnly.args = {
	category: "sizeOnly",
	activeSizeOption: [],
	onClick: action("clicked!"),
};
