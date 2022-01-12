import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import Input from ".";

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
};

export const Password = Template.bind({});
Password.args = {
	category: "password",
	content: "비밀번호",
};

export const Phone = Template.bind({});
Phone.args = {
	category: "phone",
	content: "휴대폰 번호",
};

export const Error = Template.bind({});
Error.args = {
	category: "email",
	error: true,
};
