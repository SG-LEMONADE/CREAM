import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";

import CheckBox from "./";

export default {
	title: "atoms/Checkbox",
	component: CheckBox,
} as ComponentMeta<typeof CheckBox>;

const Template: ComponentStory<typeof CheckBox> = (args) => (
	<CheckBox {...args}>{args.children}</CheckBox>
);

export const Default = Template.bind({});
Default.args = {
	children: "의류",
};
