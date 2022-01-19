import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ShoeSize from ".";

export default {
	title: "atoms/ShoeSize",
	componsne: ShoeSize,
} as ComponentMeta<typeof ShoeSize>;

const Template: ComponentStory<typeof ShoeSize> = (args) => (
	<ShoeSize {...args}>{args.children}</ShoeSize>
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
