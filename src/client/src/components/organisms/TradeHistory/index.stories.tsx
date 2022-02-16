import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import TradeHistory from ".";

export default {
	title: "organisms/TradeHistory",
	component: TradeHistory,
} as ComponentMeta<typeof TradeHistory>;

const Template: ComponentStory<typeof TradeHistory> = (args) => (
	<TradeHistory {...args}>{args.children}</TradeHistory>
);

export const BuyHistory = Template.bind({});
BuyHistory.args = {
	category: "buy",
	total: 2,
	waiting: 0,
	pending: 0,
	over: 1,
	items: [
		{
			imageUrl: [
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			],
			backgroundColor: "#ebebeb",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
		},
		{
			imageUrl: [
				"https://kream-phinf.pstatic.net/MjAyMTEyMjBfMTA4/MDAxNjM5OTg0MjQxMTYy.F0BGHeY9Lo5okE_K4MrvzWTvO5XQ72TPW7BDhqWZUHUg.0lz1wS4mL94VUWaFzY9RIoiHuARng_qo5Ss7Eir-xk0g.PNG/a_1fef41f2dc8a4c5f9ce69aff036113e3.png",
			],
			backgroundColor: "rgb(246, 238, 237)",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "270",
			tradeStatus: "FINISHED",
		},
	],
};

export const SellHistory = Template.bind({});
SellHistory.args = {
	category: "sell",
	total: 2,
	waiting: 0,
	pending: 1,
	over: 1,
	items: [
		{
			imageUrl: [
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			],
			backgroundColor: "#ebebeb",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "IN_PROGRESS",
		},
		{
			imageUrl: [
				"https://kream-phinf.pstatic.net/MjAyMTEyMjBfMTA4/MDAxNjM5OTg0MjQxMTYy.F0BGHeY9Lo5okE_K4MrvzWTvO5XQ72TPW7BDhqWZUHUg.0lz1wS4mL94VUWaFzY9RIoiHuARng_qo5Ss7Eir-xk0g.PNG/a_1fef41f2dc8a4c5f9ce69aff036113e3.png",
			],
			backgroundColor: "rgb(246, 238, 237)",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "270",
			tradeStatus: "FINISHED",
		},
	],
};

export const Empty = Template.bind({});
Empty.args = {
	category: "buy",
	total: 0,
	waiting: 0,
	pending: 0,
	over: 0,
	items: [],
};
