import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductWish from ".";

export default {
	title: "organisms/ProductWish",
	component: ProductWish,
} as ComponentMeta<typeof ProductWish>;

const Template: ComponentStory<typeof ProductWish> = (args) => (
	<ProductWish {...args}>{args.children}</ProductWish>
);

export const Default = Template.bind({});
Default.args = {
	id: 1,
	lowestAsk: null,
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMTEwMTRfNTIg/MDAxNjM0MjA1NzQ2NTYw.1QdEB-0rYUmxNkt8JD4XsIVknAaHUhQfM2nkMfPRw6Ig.1SUHYGfZc0S-K7_ls_OYEiWVKfeZVe6qgsuugyI2Clcg.PNG/a_39b383a25b8a4ab1aef1b18d3326f6e7.png",
	backgroundColor: "orange",
	productName: "Nike Dunk Low Retro PRM Halloween",
	size: "270",
};

export const Price = Template.bind({});
Price.args = {
	id: 1,
	lowestAsk: 289000,
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMTEwMTRfNTIg/MDAxNjM0MjA1NzQ2NTYw.1QdEB-0rYUmxNkt8JD4XsIVknAaHUhQfM2nkMfPRw6Ig.1SUHYGfZc0S-K7_ls_OYEiWVKfeZVe6qgsuugyI2Clcg.PNG/a_39b383a25b8a4ab1aef1b18d3326f6e7.png",
	backgroundColor: "orange",
	productName: "Nike Dunk Low Retro PRM Halloween",
	size: "270",
};
