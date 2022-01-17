import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import PriceThumbnail from ".";

export default {
	title: "atoms/PriceThumbnail",
	component: PriceThumbnail,
} as ComponentMeta<typeof PriceThumbnail>;

const Template: ComponentStory<typeof PriceThumbnail> = (args) => (
	<PriceThumbnail {...args}>{args.children}</PriceThumbnail>
);

export const Home = Template.bind({});
Home.args = {
	category: "home",
	price: 3350000,
};

export const Shop = Template.bind({});
Shop.args = {
	category: "shop",
	price: 278000,
};
