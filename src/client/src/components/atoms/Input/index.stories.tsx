import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import Input from ".";
import { action } from "@storybook/addon-actions";

export default {
	title: "atoms/Input",
	component: Input,
} as ComponentMeta<typeof Input>;

const Template: ComponentStory<typeof Input> = (args) => (
	<Input {...args}>{args.children}</Input>
);

export const Email = Template.bind({});
Email.args = {
	category: "email",
	content: "이메일 주소",
	required: true,
};

export const Password = Template.bind({});
Password.args = {
	category: "password",
	content: "비밀번호",
	required: true,
};

export const Phone = Template.bind({});
Phone.args = {
	category: "phone",
	content: "휴대폰 번호",
};

export const Sneakers = Template.bind({});
Sneakers.args = {
	category: "sneakers",
	content: "스니커즈 사이즈",
	onClick: action("Open Modal!"),
};

export const Error = Template.bind({});
Error.args = {
	category: "email",
	error: true,
};
