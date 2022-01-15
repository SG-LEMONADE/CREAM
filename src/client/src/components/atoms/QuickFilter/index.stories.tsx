import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import QuickFilter from ".";
import Icon from "../Icon";

export default {
	title: "atoms/QuickFilter",
	component: QuickFilter,
} as ComponentMeta<typeof QuickFilter>;

const Template: ComponentStory<typeof QuickFilter> = (args) => (
	<QuickFilter {...args}>{args.children}</QuickFilter>
);

export const PlainText = Template.bind({});
PlainText.args = {
	content: "스니커즈",
};

export const FilterIcon = Template.bind({});
FilterIcon.args = {
	content: <Icon name="Filter" style={{ width: "20px", height: "20px" }} />,
};
