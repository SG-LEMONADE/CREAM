import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import HomeTemplate from ".";
import HeaderTop from "components/organisms/HeaderTop";

export default {
	title: "templates/HomeTemplate",
	component: HomeTemplate,
} as ComponentMeta<typeof HomeTemplate>;

const Template: ComponentStory<typeof HomeTemplate> = (args) => (
	<HomeTemplate {...args}>{args.children}</HomeTemplate>
);

export const Default = Template.bind({});
Default.args = {
	header: <HeaderTop />,
	children: <h1>Home screen</h1>,
};
