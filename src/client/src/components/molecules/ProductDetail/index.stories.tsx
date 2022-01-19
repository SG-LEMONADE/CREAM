import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductDetail from ".";

export default {
	title: "molecules/ProductDetail",
	component: ProductDetail,
} as ComponentMeta<typeof ProductDetail>;

const Template: ComponentStory<typeof ProductDetail> = (args) => (
	<ProductDetail {...args}>{args.children}</ProductDetail>
);

export const Default = Template.bind({});
Default.args = {
	modelNum: "DD3357-100",
	releasedAt: "220118",
	color: "SAIL/STARFISH-BLACK",
	price: 129000,
};
