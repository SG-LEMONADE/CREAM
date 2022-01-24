import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import MyPageSidebar from ".";

export default {
	title: "organisms/MyPageSidebar",
	component: MyPageSidebar,
} as ComponentMeta<typeof MyPageSidebar>;

const Template: ComponentStory<typeof MyPageSidebar> = (args) => (
	<MyPageSidebar {...args}>{args.children}</MyPageSidebar>
);

export const Default = Template.bind({});
Default.args = {};
