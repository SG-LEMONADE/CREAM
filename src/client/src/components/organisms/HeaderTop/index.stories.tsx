import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import HeaderTop from ".";

export default {
	title: "organisms/HeaderTop",
	component: HeaderTop,
} as ComponentMeta<typeof HeaderTop>;

const Template: ComponentStory<typeof HeaderTop> = (args) => (
	<HeaderTop {...args}>{args.children}</HeaderTop>
);

export const Default = Template.bind({});
Default.args = {};
