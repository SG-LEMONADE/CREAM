import React from "react";
import { ComponentStory, ComponentMeta } from "@storybook/react";

import Knob from "./";

export default {
	title: "atoms/Knob",
	component: Knob,
} as ComponentMeta<typeof Knob>;

const Template: ComponentStory<typeof Knob> = (args) => (
	<Knob {...args}>{args.children}</Knob>
);

export const Buy = Template.bind({});
Buy.args = {
	category: "buy",
	price: 262000,
};

export const Sell = Template.bind({});
Sell.args = {
	category: "sell",
	price: 262000,
};
