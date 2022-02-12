import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import SizeSelectTemplate from ".";

export default {
	title: "templates/SizeSelectTemplate",
	component: SizeSelectTemplate,
} as ComponentMeta<typeof SizeSelectTemplate>;

const Template: ComponentStory<typeof SizeSelectTemplate> = (args) => (
	<SizeSelectTemplate {...args}>{args.children}</SizeSelectTemplate>
);

export const Buy = Template.bind({});
Buy.args = {
	category: "buy",
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMjAxMTFfMTgz/MDAxNjQxODk0OTEwNDkz.yjpQl2LYd3NjYlowBnIAwCgqsvRkjiyRMIOUHqKas7Ug.nBYnJxoNrMke_rg09-HX3X_LB3Tp3o_53lALlvFBSmAg.PNG/a_4d5c1b5f5165488bbb39597002611df3.png?type=m",
	backgroundColor: "rgb(235, 240, 245)",
	styledCode: "DH7568-002",
	originalName: "Nike Air Force 1 '07 LV8 Athletic Club Black Dark Sulfur",
	translatedName: "나이키 에어포스 1 '07 LV8 애슬레틱 클럽 블랙 다크 설퍼",
	sizes: [
		"220",
		"225",
		"230",
		"235",
		"240",
		"245",
		"250",
		"255",
		"260",
		"265",
		"270",
		"275",
		"280",
		"285",
		"290",
	],
	pricePerSize: {
		"220": 120000,
		"225": 125000,
		"230": 140000,
		"235": 130000,
		"240": 132000,
		"245": 110000,
		"250": null,
		"255": null,
		"260": 112000,
		"265": 120000,
		"270": null,
		"275": null,
		"280": null,
		"285": 140000,
		"290": 120000,
		"모든 사이즈": null,
	},
};
