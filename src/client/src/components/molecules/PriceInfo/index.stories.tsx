import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import PriceInfo from ".";

export default {
	title: "molecules/PriceInfo",
	component: PriceInfo,
} as ComponentMeta<typeof PriceInfo>;

const Template: ComponentStory<typeof PriceInfo> = (args) => (
	<PriceInfo {...args}>{args.children}</PriceInfo>
);

export const Default = Template.bind({});
Default.args = {
	askPrice: null,
	bidPrice: 148000,
};
