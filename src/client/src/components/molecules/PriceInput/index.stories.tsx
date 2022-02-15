import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import PriceInput from ".";

export default {
	title: "molecules/PriceInput",
	component: PriceInput,
} as ComponentMeta<typeof PriceInput>;

const Template: ComponentStory<typeof PriceInput> = (args) => (
	<PriceInput {...args}>{args.children}</PriceInput>
);

export const BuyAuction = Template.bind({});
BuyAuction.args = {
	category: "buy",
	auction: true,
};

export const BuyNonAuction = Template.bind({});
BuyNonAuction.args = {
	category: "buy",
	auction: false,
};

export const SellAuction = Template.bind({});
SellAuction.args = {
	category: "sell",
	auction: true,
};

export const SellNonAuction = Template.bind({});
SellNonAuction.args = {
	category: "sell",
	auction: false,
};
