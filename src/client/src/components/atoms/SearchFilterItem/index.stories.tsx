import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import SearchFilterItem from ".";

export default {
	title: "atoms/SearchFilterItem",
	component: SearchFilterItem,
} as ComponentMeta<typeof SearchFilterItem>;

const Template: ComponentStory<typeof SearchFilterItem> = (args) => (
	<SearchFilterItem {...args}>{args.children}</SearchFilterItem>
);

export const Default = Template.bind({});
Default.args = {};
