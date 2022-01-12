import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import Brand from "./";

export default {
	title: "atoms/Brand",
	component: Brand,
} as ComponentMeta<typeof Brand>;

const Template: ComponentStory<typeof Brand> = (args) => (
	<Brand {...args}>{args.children}</Brand>
);

export const Home = Template.bind({});
Home.args = {
	children: "Chanel",
	category: "home",
};

export const Shop = Template.bind({});
Shop.args = {
	children: "Jordan",
	category: "shop",
};

export const Product = Template.bind({});
Product.args = {
	children: "Acne Studios",
	category: "product",
};
