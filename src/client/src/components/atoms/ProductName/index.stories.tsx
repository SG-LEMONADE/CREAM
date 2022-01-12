import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductName from ".";

export default {
	title: "atoms/ProductName",
	component: ProductName,
} as ComponentMeta<typeof ProductName>;

const Template: ComponentStory<typeof ProductName> = (args) => (
	<ProductName {...args}>{args.children}</ProductName>
);

export const Home = Template.bind({});
Home.args = {
	children:
		"Chanel Mini Flap Bag with Top Handle Lambskin & Champagne Gold Black",
	category: "home",
};

export const Shop = Template.bind({});
Shop.args = {
	children: "Jordan 1 Retro High OG Black Mocha",
	category: "shop",
};

export const Product = Template.bind({});
Product.args = {
	children: "Acne Studios Baker Out Medium Tote Bag Brown Pink",
	category: "product",
};
