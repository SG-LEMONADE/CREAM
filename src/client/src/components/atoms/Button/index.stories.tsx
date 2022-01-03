import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";

import Button from "./";

export default {
	title: "atoms/Button",
	component: Button,
} as ComponentMeta<typeof Button>;

const Template: ComponentStory<typeof Button> = (args) => (
	<Button {...args}>{args.children}</Button>
);

export const Primary = Template.bind({});
Primary.args = {
	category: "primary",
	children: "더보기",
};

export const PrimaryDisabled = Template.bind({});
PrimaryDisabled.args = {
	category: "primary",
	children: "비활성화",
	disabled: true,
};

export const secondary_buy = Template.bind({});
secondary_buy.args = {
	category: "secondary_buy",
	children: "판매",
};

export const secondary_sell = Template.bind({});
secondary_sell.args = {
	category: "secondary_sell",
	children: "구매",
};
