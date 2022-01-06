import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";
import { action } from "@storybook/addon-actions";

import HeaderMainItem from ".";

export default {
	title: "atoms/HeaderMainItem",
	component: HeaderMainItem,
	args: {
		onClick: action("Change Link to /shop"),
	},
} as ComponentMeta<typeof HeaderMainItem>;

const Template: ComponentStory<typeof HeaderMainItem> = (args) => (
	<HeaderMainItem {...args}>{args.children}</HeaderMainItem>
);

export const Default = Template.bind({});
Default.args = {
	children: "SHOP",
};
