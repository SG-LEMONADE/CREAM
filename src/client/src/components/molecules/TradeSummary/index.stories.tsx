import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import TradeSummary from ".";

export default {
	title: "molecules/TradeSummary",
	component: TradeSummary,
} as ComponentMeta<typeof TradeSummary>;

const Template: ComponentStory<typeof TradeSummary> = (args) => (
	<TradeSummary {...args}>{args.children}</TradeSummary>
);

export const Buy = Template.bind({});
Buy.args = {
	category: "buy",
	total: 1,
	waiting: 2,
	pending: 0,
	over: 1,
};

export const Sell = Template.bind({});
Sell.args = {
	category: "sell",
	total: 1,
	waiting: 2,
	pending: 0,
	over: 1,
};
