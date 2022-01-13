import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import HeaderMain from "./";

export default {
	title: "organisms/HeaderMain",
	component: HeaderMain,
} as ComponentMeta<typeof HeaderMain>;

const Template: ComponentStory<typeof HeaderMain> = (args) => (
	<HeaderMain {...args}>{args.children}</HeaderMain>
);

export const Default = Template.bind({});
Default.args = {};
