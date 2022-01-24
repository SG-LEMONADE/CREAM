import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import UserDetail from ".";

export default {
	title: "molecules/UserDetail",
	component: UserDetail,
} as ComponentMeta<typeof UserDetail>;

const Template: ComponentStory<typeof UserDetail> = (args) => (
	<UserDetail {...args}>{args.children}</UserDetail>
);

export const Default = Template.bind({});
Default.args = {
	userName: "레모네이드",
	userEmail: "lemonade@naver.com",
};

export const Img = Template.bind({});
Img.args = {
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMjAxMjRfMjg5/MDAxNjQzMDI2NDgwMDQ2.q7o8WyuEQ5xtRv7K19K75MHFR-JjTVO9Z7OodcuJlbwg.bwTvambuGuco17SSX-s1SbnEoCRkkB4oof9mFeo84ucg.PNG/p_7286f8e71954403c8e3d7ca37d5e3ef8.png",
	userName: "레모네이드",
	userEmail: "qwerty1234@naver.com",
};
