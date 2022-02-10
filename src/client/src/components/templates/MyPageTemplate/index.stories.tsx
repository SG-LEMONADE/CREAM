import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import MyPageTemplate from ".";

export default {
	title: "templates/MyPageTemplate",
	component: MyPageTemplate,
} as ComponentMeta<typeof MyPageTemplate>;

const Template: ComponentStory<typeof MyPageTemplate> = (args) => (
	<MyPageTemplate {...args}>{args.children}</MyPageTemplate>
);

export const Default = Template.bind({});
Default.args = {};
