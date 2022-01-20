import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductRecentPrice from ".";

export default {
	title: "molecules/ProductRecentPrice",
	component: ProductRecentPrice,
} as ComponentMeta<typeof ProductRecentPrice>;

const Template: ComponentStory<typeof ProductRecentPrice> = (args) => (
	<ProductRecentPrice {...args}>{args.children}</ProductRecentPrice>
);

export const Increase = Template.bind({});
Increase.args = {
	category: "increase",
	amount: 5000,
	percentage: 0.7,
	price: 752000,
};

export const Decrease = Template.bind({});
Decrease.args = {
	category: "decrease",
	amount: 5000,
	percentage: 0.5,
	price: 2040000,
};
