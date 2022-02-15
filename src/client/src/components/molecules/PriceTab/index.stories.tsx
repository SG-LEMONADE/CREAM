import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import PriceTab from ".";

export default {
	title: "molecules/PriceTab",
	component: PriceTab,
} as ComponentMeta<typeof PriceTab>;

const Template: ComponentStory<typeof PriceTab> = (args) => (
	<PriceTab {...args}>{args.children}</PriceTab>
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

export const BuyAuctionBlocked = Template.bind({});
BuyAuctionBlocked.args = {
	category: "buy",
	auction: true,
	blocked: true,
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

export const SellAuctionBlocked = Template.bind({});
SellAuctionBlocked.args = {
	category: "sell",
	auction: true,
	blocked: true,
};
