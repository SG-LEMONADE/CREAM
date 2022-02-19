import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import TransactionTitle from ".";

export default {
	title: "atoms/TransactionTitle",
	component: TransactionTitle,
} as ComponentMeta<typeof TransactionTitle>;

const Template: ComponentStory<typeof TransactionTitle> = (args) => (
	<TransactionTitle {...args}>{args.children}</TransactionTitle>
);

export const Buy = Template.bind({});
Buy.args = {
	category: "buy",
};

export const BuyAuction = Template.bind({});
BuyAuction.args = {
	category: "ask",
};

export const Sell = Template.bind({});
Sell.args = {
	category: "sell",
};

export const SellAuction = Template.bind({});
SellAuction.args = {
	category: "bid",
};
