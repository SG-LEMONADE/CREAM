import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import SizeSelect from ".";

export default {
	title: "molecules/SizeSelect",
	component: SizeSelect,
} as ComponentMeta<typeof SizeSelect>;

const Template: ComponentStory<typeof SizeSelect> = (args) => (
	<SizeSelect {...args}>{args.children}</SizeSelect>
);

export const Default = Template.bind({});
Default.args = {};
