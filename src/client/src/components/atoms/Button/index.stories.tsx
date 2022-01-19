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

export const PrimaryFull = Template.bind({});
PrimaryFull.args = {
	category: "primary",
	children: "구매 계속",
	fullWidth: true,
};

export const PrimaryFullDisabled = Template.bind({});
PrimaryFullDisabled.args = {
	category: "primary",
	children: "구매 계속",
	fullWidth: true,
	disabled: true,
};
