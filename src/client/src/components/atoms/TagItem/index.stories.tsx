import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import TagItem from ".";
import { action } from "@storybook/addon-actions";

export default {
	title: "atoms/TagItem",
	component: TagItem,
} as ComponentMeta<typeof TagItem>;

const Template: ComponentStory<typeof TagItem> = (args) => (
	<TagItem {...args}>{args.children}</TagItem>
);

export const Default = Template.bind({});
Default.args = {
	children: "스니커즈",
	onClick: action("Removed!"),
};
