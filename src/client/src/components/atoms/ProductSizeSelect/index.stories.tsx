import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductSizeSelect from ".";

export default {
	title: "atoms/ProductSizeSelect",
	componsne: ProductSizeSelect,
} as ComponentMeta<typeof ProductSizeSelect>;

const Template: ComponentStory<typeof ProductSizeSelect> = (args) => (
	<ProductSizeSelect {...args}>{args.children}</ProductSizeSelect>
);

export const Buy = Template.bind({});
Buy.args = {
	category: "buy",
	size: 245,
	price: 420000,
};

export const BuyActive = Template.bind({});
BuyActive.args = {
	category: "buy",
	size: 320,
	price: 235000,
	active: true,
};

export const Sell = Template.bind({});
Sell.args = {
	category: "sell",
	size: 245,
	price: 420000,
};

export const SellActive = Template.bind({});
SellActive.args = {
	category: "sell",
	size: 320,
	price: 235000,
	active: true,
};

export const Wish = Template.bind({});
Wish.args = {
	category: "wish",
	size: 220,
};

export const WishActive = Template.bind({});
WishActive.args = {
	category: "wish",
	size: 220,
	active: true,
};

export const sizeOnly = Template.bind({});
sizeOnly.args = {
	category: "sizeOnly",
	size: 220,
	active: false,
};

export const sizeOnlyActive = Template.bind({});
sizeOnlyActive.args = {
	category: "sizeOnly",
	size: 220,
	active: true,
};
