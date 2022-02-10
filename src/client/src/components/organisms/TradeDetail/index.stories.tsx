import React from "react";
import { ComponentMeta, ComponentStory } from "@storybook/react";

import TradeDetail from ".";
import { action } from "@storybook/addon-actions";

export default {
	title: "organisms/TradeDetail",
	component: TradeDetail,
} as ComponentMeta<typeof TradeDetail>;

const Template: ComponentStory<typeof TradeDetail> = (args) => (
	<TradeDetail {...args}>{args.children}</TradeDetail>
);

export const Buy = Template.bind({});
Buy.args = {
	category: "buy",
	waiting: 1,
	in_progress: 1,
	finished: 4,
	onClick: action("!"),
	items: [
		{
			backgroundColor: "#ebebeb",
			imageUrl:
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Daolo Swoosh Fleece Hoodie Daolo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
			updateDateTime: "2022-02-10T02:19:13.249Z",
			validationDate: "2022-02-10T02:19:13.249Z",
		},
		{
			backgroundColor: "#ebebeb",
			imageUrl:
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
			updateDateTime: "2022-02-10T02:19:13.249Z",
			validationDate: "2022-02-10T02:19:13.249Z",
		},
		{
			backgroundColor: "#ebebeb",
			imageUrl:
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
			updateDateTime: "2022-02-10T02:19:13.249Z",
			validationDate: "2022-02-10T02:19:13.249Z",
		},
		{
			backgroundColor: "#ebebeb",
			imageUrl:
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
			updateDateTime: "2022-02-10T02:19:13.249Z",
			validationDate: "2022-02-10T02:19:13.249Z",
		},
	],
};

export const Sell = Template.bind({});
Sell.args = {
	category: "sell",
	waiting: 1,
	in_progress: 1,
	finished: 4,
	onClick: action("!"),
	items: [
		{
			backgroundColor: "#ebebeb",
			imageUrl:
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Daolo Swoosh Fleece Hoodie Daolo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
			updateDateTime: "2022-02-10T02:19:13.249Z",
			validationDate: "2022-02-10T02:19:13.249Z",
		},
		{
			backgroundColor: "#ebebeb",
			imageUrl:
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
			updateDateTime: "2022-02-10T02:19:13.249Z",
			validationDate: "2022-02-10T02:19:13.249Z",
		},
		{
			backgroundColor: "#ebebeb",
			imageUrl:
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
			updateDateTime: "2022-02-10T02:19:13.249Z",
			validationDate: "2022-02-10T02:19:13.249Z",
		},
		{
			backgroundColor: "#ebebeb",
			imageUrl:
				"https://kream-phinf.pstatic.net/MjAyMTA0MTJfNjgg/MDAxNjE4MjA4ODE0MjI3.TrFMsOubBPIX-fyqngJoHiN1h78jPSgISjKBBnRlCakg.QqX73fbXeQ_s69-Ydb4ccVBbQl9OKfiXQL5KUCAH7lcg.JPEG/p_e8c137c6c4de415781c61512464dc384.jpg?type=m",
			name: "Nike NRG Solo Swoosh Fleece Hoodie Dark Grey Heather - Asia",
			size: "L",
			tradeStatus: "WAITING",
			updateDateTime: "2022-02-10T02:19:13.249Z",
			validationDate: "2022-02-10T02:19:13.249Z",
		},
	],
};
