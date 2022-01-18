import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import LoginForm from ".";

export default {
	title: "organisms/LoginForm",
	contents: LoginForm,
} as ComponentMeta<typeof LoginForm>;

const Template: ComponentStory<typeof LoginForm> = (args) => (
	<LoginForm {...args}>{args.children}</LoginForm>
);

export const Default = Template.bind({});
Default.args = {};
