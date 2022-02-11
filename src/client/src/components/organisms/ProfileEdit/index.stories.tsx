import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import ProfileEdit from ".";

export default {
	title: "organisms/ProfileEdit",
	component: ProfileEdit,
} as ComponentMeta<typeof ProfileEdit>;

const Template: ComponentStory<typeof ProfileEdit> = (args) => (
	<ProfileEdit {...args}>{args.children}</ProfileEdit>
);

export const Default = Template.bind({});
Default.args = {
	email: "test1234@naver.com",
	password: "1q2w3e4r!@#",
	name: null,
	address: null,
	shoeSize: 265,
};
