import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import Floater from ".";

export default {
	title: "organisms/Floater",
	component: Floater,
} as ComponentMeta<typeof Floater>;

const Template: ComponentStory<typeof Floater> = (args) => (
	<Floater {...args}>{args.children}</Floater>
);

export const Default = Template.bind({});
Default.args = {
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMTEwMTRfNTIg/MDAxNjM0MjA1NzQ2NTYw.1QdEB-0rYUmxNkt8JD4XsIVknAaHUhQfM2nkMfPRw6Ig.1SUHYGfZc0S-K7_ls_OYEiWVKfeZVe6qgsuugyI2Clcg.PNG/a_39b383a25b8a4ab1aef1b18d3326f6e7.png",
	backgroundColor: "orange",
	productName: "Nike Dunk Low Retro PRM Halloween",
	productNameKor: "나이키 덩크 로우 레트로 프리미엄 할로윈",
	isWishProduct: true,
	wishes: 9913,
	productId: 43374,
	buyPrice: 265000,
	sellPrice: 370000,
};
