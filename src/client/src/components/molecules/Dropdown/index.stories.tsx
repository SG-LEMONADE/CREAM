import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import Dropdown from ".";

export default {
	title: "molecules/Dropdown",
	component: Dropdown,
} as ComponentMeta<typeof Dropdown>;

const Template: ComponentStory<typeof Dropdown> = (args) => (
	<Dropdown {...args}>{args.children}</Dropdown>
);

export const Default = Template.bind({});
Default.args = {};
