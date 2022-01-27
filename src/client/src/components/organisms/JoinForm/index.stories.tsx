import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import JoinForm from ".";

export default {
	title: "organisms/JoinForm",
	contents: JoinForm,
} as ComponentMeta<typeof JoinForm>;

const Template: ComponentStory<typeof JoinForm> = (args) => (
	<JoinForm {...args}>{args.children}</JoinForm>
);

export const Default = Template.bind({});
Default.args = {};
