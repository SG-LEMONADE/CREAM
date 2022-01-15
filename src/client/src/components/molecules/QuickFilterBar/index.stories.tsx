import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import QuickFilterBar from ".";

export default {
	title: "molecules/QuickFilterBar",
	component: QuickFilterBar,
} as ComponentMeta<typeof QuickFilterBar>;

const Template: ComponentStory<typeof QuickFilterBar> = (args) => (
	<QuickFilterBar {...args}>{args.children}</QuickFilterBar>
);

export const Default = Template.bind({});
Default.args = {};
