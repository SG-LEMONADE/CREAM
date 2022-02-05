import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";

import HomeTemplate from ".";

export default {
	title: "templates/HomeTemplate",
	comonent: HomeTemplate,
} as ComponentMeta<typeof HomeTemplate>;

const Template: ComponentStory<typeof HomeTemplate> = (args) => (
	<HomeTemplate {...args}>{args.children}</HomeTemplate>
);

export const Default = Template.bind({});
Default.args = {
	children: <h1>Home</h1>,
};
