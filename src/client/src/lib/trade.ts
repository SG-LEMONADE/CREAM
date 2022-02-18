import axios from "axios";

import { getToken } from "lib/token";

export const onHandleTrade = async (
	category: string,
	auction: boolean,
	date: number,
	price: number,
	id: number,
	size: string,
) => {
	const token = getToken("accessToken");

	if (auction) {
		// 경매 형식
		try {
			const res = await axios.post(
				`${process.env.END_POINT_PRODUCT}/trades/products/${id}/${size}`,
				{
					price: price,
					requestType: category === "buy" ? `ASK` : `BID`,
					validationDay: date,
				},
				{
					headers: {
						Authorization: `Bearer ${token}`,
					},
				},
			);
		} catch (e) {
			console.error(e);
		}
	} else {
		// 즉시 거래
		try {
			const res = await axios.post(
				`${process.env.END_POINT_PRODUCT}/trades/${category}/select/${id}/${size}`,
				{},
				{
					headers: {
						Authorization: `Bearer ${token}`,
					},
				},
			);
		} catch (e) {
			console.error(e);
		}
	}
};
