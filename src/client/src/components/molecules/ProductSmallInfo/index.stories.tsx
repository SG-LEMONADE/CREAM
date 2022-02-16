import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProductSmallInfo from ".";

export default {
	title: "molecules/ProductSmallInfo",
	component: ProductSmallInfo,
} as ComponentMeta<typeof ProductSmallInfo>;

const Template: ComponentStory<typeof ProductSmallInfo> = (args) => (
	<ProductSmallInfo {...args}>{args.children}</ProductSmallInfo>
);

export const Default = Template.bind({});
Default.args = {
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMTEwMTRfNTIg/MDAxNjM0MjA1NzQ2NTYw.1QdEB-0rYUmxNkt8JD4XsIVknAaHUhQfM2nkMfPRw6Ig.1SUHYGfZc0S-K7_ls_OYEiWVKfeZVe6qgsuugyI2Clcg.PNG/a_39b383a25b8a4ab1aef1b18d3326f6e7.png",
	backgroundColor: "orange",
	productName: "Nike Dunk Low Retro PRM Halloween",
	productNameKor: "나이키 덩크 로우 레트로 프리미엄 할로윈",
};

export const Size = Template.bind({});
Size.args = {
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
	backgroundColor: "rgb(235, 240, 245)",
	productName: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
	size: "L",
};

export const Transaction = Template.bind({});
Transaction.args = {
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMjAxMTFfMTgz/MDAxNjQxODk0OTEwNDkz.yjpQl2LYd3NjYlowBnIAwCgqsvRkjiyRMIOUHqKas7Ug.nBYnJxoNrMke_rg09-HX3X_LB3Tp3o_53lALlvFBSmAg.PNG/a_4d5c1b5f5165488bbb39597002611df3.png?type=m",
	backgroundColor: "rgb(235, 240, 245)",
	styleCode: "DH7568-002",
	productName: "Nike Air Force 1 '07 LV8 Athletic Club Black Dark Sulfur",
	productNameKor: "나이키 에어포스 1 '07 LV8 애슬레틱 클럽 블랙 다크 설퍼",
};
