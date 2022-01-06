import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";
import { action } from "@storybook/addon-actions";

import HeaderTopItem from ".";

export default {
	title: "atoms/HeaderTopItem",
	component: HeaderTopItem,
	args: {
		onClick: action("Change Link to /wish"),
	},
} as ComponentMeta<typeof HeaderTopItem>;

const Template: ComponentStory<typeof HeaderTopItem> = (args) => (
	<HeaderTopItem {...args}>{args.children}</HeaderTopItem>
);

export const Default = Template.bind({});
Default.args = {
	children: "관심상품",
};
