import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import DeadLine from ".";
import { action } from "@storybook/addon-actions";

export default {
	title: "molecules/DeadLine",
	component: DeadLine,
} as ComponentMeta<typeof DeadLine>;

const Template: ComponentStory<typeof DeadLine> = (args) => (
	<DeadLine {...args}>{args.children}</DeadLine>
);

export const Default = Template.bind({});
Default.args = {
	setDueDate: action("!"),
};
