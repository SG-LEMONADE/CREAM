import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import TradeTab from ".";

export default {
	title: "molecules/TradeTab",
	component: TradeTab,
} as ComponentMeta<typeof TradeTab>;

const Template: ComponentStory<typeof TradeTab> = (args) => (
	<TradeTab {...args}>{args.children}</TradeTab>
);

export const Buy = Template.bind({});
Buy.args = {
	category: "buy",
	waiting: 1,
	in_progress: 2,
	finished: 1,
};

export const Sell = Template.bind({});
Sell.args = {
	category: "sell",
	waiting: 1,
	in_progress: 2,
	finished: 1,
};
