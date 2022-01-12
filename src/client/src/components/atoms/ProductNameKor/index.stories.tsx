import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductNameKor from ".";

export default {
	title: "atoms/ProductNameKor",
	component: ProductNameKor,
} as ComponentMeta<typeof ProductNameKor>;

const Template: ComponentStory<typeof ProductNameKor> = (args) => (
	<ProductNameKor {...args}>{args.children}</ProductNameKor>
);

export const Shop = Template.bind({});
Shop.args = {
	children: "조던 1 레트로 하이 OG 블랙 모카",
	category: "shop",
};

export const Product = Template.bind({});
Product.args = {
	children: "아크네 스튜디오 베이커 아웃 미디움 토트백 브라운 핑크",
	category: "product",
};
