import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import SearchFilterItem from ".";
import { action } from "@storybook/addon-actions";

export default {
	title: "atoms/SearchFilterItem",
	component: SearchFilterItem,
} as ComponentMeta<typeof SearchFilterItem>;

const Template: ComponentStory<typeof SearchFilterItem> = (args) => (
	<SearchFilterItem {...args}>{args.children}</SearchFilterItem>
);

export const Brand = Template.bind({});
Brand.args = {
	title: "브랜드",
	optionsList: [
		"A.P.C",
		"Acne Studios",
		"Ader Error",
		"Alexander McQueen",
		"Anti Socil Socil Club",
		"Adidas",
		"Vey Very long brand name",
		"123",
		"1234",
		"23123123123123",
		"apple",
		"Asics",
		"Kream",
		"lemonade",
		"Dev camp",
		"Ezreal",
		"LOL",
		"Lulu",
	],
};

export const Category = Template.bind({});
Category.args = {
	title: "카테고리",
	optionsList: ["의류", "스니커즈", "패션 잡화", "라이프", "테크"],
	onlyOneChecked: true,
};
