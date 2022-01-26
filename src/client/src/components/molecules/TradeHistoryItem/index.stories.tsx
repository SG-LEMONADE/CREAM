import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import TradeHistoryItem from ".";

export default {
	title: "molecules/TradeHistoryItem",
	component: TradeHistoryItem,
} as ComponentMeta<typeof TradeHistoryItem>;

const Template: ComponentStory<typeof TradeHistoryItem> = (args) => (
	<TradeHistoryItem {...args}>{args.children}</TradeHistoryItem>
);

export const HistoryItem = Template.bind({});
HistoryItem.args = {
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
	backgroundColor: "#ebebeb",
	productName: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
	size: "L",
	status: 0,
};

export const HistoryList = Template.bind({});
HistoryList.args = {
	imgSrc:
		"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
	backgroundColor: "#ebebeb",
	productName: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
	size: "L",
	wishedPrice: 70000,
	expiredDate: "20220224",
};
