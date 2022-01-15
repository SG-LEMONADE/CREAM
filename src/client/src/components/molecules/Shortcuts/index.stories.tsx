import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";

import Shortcuts from "./";

export default {
	title: "molecules/Shortcuts",
	component: Shortcuts,
} as ComponentMeta<typeof Shortcuts>;

const Template: ComponentStory<typeof Shortcuts> = (args) => (
	<Shortcuts {...args}>{args.children}</Shortcuts>
);

export const Default = Template.bind({});
Default.args = {};
