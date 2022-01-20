import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import SizeSelect from ".";
import { action } from "@storybook/addon-actions";

export default {
	title: "molecules/SizeSelect",
	component: SizeSelect,
	args: {
		onClick: action("clicked"),
	},
} as ComponentMeta<typeof SizeSelect>;

const Template: ComponentStory<typeof SizeSelect> = (args) => (
	<SizeSelect {...args}>{args.children}</SizeSelect>
);

export const Default = Template.bind({});
Default.args = {
	children: 270,
};

export const OneSize = Template.bind({});
OneSize.args = {
	children: "ONE SIZE",
};
