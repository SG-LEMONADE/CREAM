import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import SearchFilterBar from ".";

export default {
	title: "organisms/SearchFilterBar",
	component: SearchFilterBar,
} as ComponentMeta<typeof SearchFilterBar>;

const Template: ComponentStory<typeof SearchFilterBar> = (args) => (
	<SearchFilterBar {...args}>{args.children}</SearchFilterBar>
);

export const Default = Template.bind({});
Default.args = {};
