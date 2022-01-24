import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import MyPageSiderbarItem from ".";

export default {
	title: "atoms/MyPageSidebarItem",
	component: MyPageSiderbarItem,
} as ComponentMeta<typeof MyPageSiderbarItem>;

const Template: ComponentStory<typeof MyPageSiderbarItem> = (args) => (
	<MyPageSiderbarItem {...args}>{args.children}</MyPageSiderbarItem>
);

export const Subtitle = Template.bind({});
Subtitle.args = {
	category: "subtitle",
	children: "쇼핑 정보",
};

export const Menu = Template.bind({});
Menu.args = {
	category: "menu",
	children: "구매 내역",
};
