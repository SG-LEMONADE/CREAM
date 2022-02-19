import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import CompleteTemplate from ".";

export default {
	title: "templates/CompleteTemplate",
	component: CompleteTemplate,
} as ComponentMeta<typeof CompleteTemplate>;

const Template: ComponentStory<typeof CompleteTemplate> = (args) => (
	<CompleteTemplate {...args}>{args.children}</CompleteTemplate>
);

export const BuyAuction = Template.bind({});
BuyAuction.args = {
	category: "buy",
	auction: true,
	imageUrl:
		"https://kream-phinf.pstatic.net/MjAyMTA3MjhfMjIg/MDAxNjI3NDQxMDA1NjE5.HOgIYywGZaaBJDqUzx2OnX9HAxoOWPvuWHqUn_LZGcgg.VYIuOfA5_GgjBGRowv6dmQuAOPtUvmAxbGpOyUCOCtYg.PNG/p_9d8ed1a74d2540ab9842e63363607bf4.png?type=m",
	backgroundColor: "rgba(235, 240, 245)",
	price: 120000,
	date: 30,
};

export const BuyNotAuction = Template.bind({});
BuyNotAuction.args = {
	category: "buy",
	auction: false,
	imageUrl:
		"https://kream-phinf.pstatic.net/MjAyMTA3MjhfMjIg/MDAxNjI3NDQxMDA1NjE5.HOgIYywGZaaBJDqUzx2OnX9HAxoOWPvuWHqUn_LZGcgg.VYIuOfA5_GgjBGRowv6dmQuAOPtUvmAxbGpOyUCOCtYg.PNG/p_9d8ed1a74d2540ab9842e63363607bf4.png?type=m",
	backgroundColor: "rgba(235, 240, 245)",
	price: 120000,
};

export const SellAuction = Template.bind({});
SellAuction.args = {
	category: "sell",
	auction: true,
	imageUrl:
		"https://kream-phinf.pstatic.net/MjAyMTA3MjhfMjIg/MDAxNjI3NDQxMDA1NjE5.HOgIYywGZaaBJDqUzx2OnX9HAxoOWPvuWHqUn_LZGcgg.VYIuOfA5_GgjBGRowv6dmQuAOPtUvmAxbGpOyUCOCtYg.PNG/p_9d8ed1a74d2540ab9842e63363607bf4.png?type=m",
	backgroundColor: "rgba(235, 240, 245)",
	price: 120000,
	date: 30,
};

export const SellNotAuction = Template.bind({});
SellNotAuction.args = {
	category: "sell",
	auction: false,
	imageUrl:
		"https://kream-phinf.pstatic.net/MjAyMTA3MjhfMjIg/MDAxNjI3NDQxMDA1NjE5.HOgIYywGZaaBJDqUzx2OnX9HAxoOWPvuWHqUn_LZGcgg.VYIuOfA5_GgjBGRowv6dmQuAOPtUvmAxbGpOyUCOCtYg.PNG/p_9d8ed1a74d2540ab9842e63363607bf4.png?type=m",
	backgroundColor: "rgba(235, 240, 245)",
	price: 120000,
};
